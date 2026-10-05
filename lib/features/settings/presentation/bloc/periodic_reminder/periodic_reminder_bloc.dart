import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:muslim/core/service/periodic_reminder_constants.dart';
import 'package:muslim/core/service/periodic_reminder_service.dart';
import 'package:muslim/features/settings/data/services/periodic_reminder_repository.dart';
import 'package:muslim/features/settings/presentation/bloc/periodic_reminder/periodic_reminder_event.dart';

export 'periodic_reminder_event.dart';

part 'periodic_reminder_bloc.freezed.dart';

// ─────────────────────────────────────────────────────────────────────────────
// STATE
// ─────────────────────────────────────────────────────────────────────────────

@freezed
abstract class PeriodicReminderState with _$PeriodicReminderState {
  const factory PeriodicReminderState({
    @Default(PeriodicReminderConstants.defaultEnabled) bool enabled,
    @Default(PeriodicReminderConstants.defaultIntervalMinutes) int intervalMinutes,
    @Default(false) bool isLoading,
    String? error,
  }) = _PeriodicReminderState;
}

// ─────────────────────────────────────────────────────────────────────────────
// BLOC
// ─────────────────────────────────────────────────────────────────────────────

class PeriodicReminderBloc extends Bloc<PeriodicReminderEvent, PeriodicReminderState> {
  PeriodicReminderBloc({
    PeriodicReminderRepository? repository,
    PeriodicReminderService? service,
  }) : _repository = repository ?? PeriodicReminderRepository(),
       _service = service ?? PeriodicReminderService(),
       super(const PeriodicReminderState()) {
    on<PeriodicReminderLoadSettings>(_onLoadSettings);
    on<PeriodicReminderToggleEnabled>(_onToggleEnabled);
    on<PeriodicReminderSetInterval>(_onSetInterval);
    on<PeriodicReminderRescheduleIfEnabled>(_onRescheduleIfEnabled);
    on<PeriodicReminderCancelAndReset>(_onCancelAndReset);
    on<PeriodicReminderRefresh>(_onRefresh);

    add(const PeriodicReminderEvent.loadSettings());
  }

  final PeriodicReminderRepository _repository;
  final PeriodicReminderService _service;

  Future<void> _onLoadSettings(
    PeriodicReminderLoadSettings event,
    Emitter<PeriodicReminderState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final settings = await _repository.loadSettings();
      emit(
        state.copyWith(
          enabled: settings.enabled,
          intervalMinutes: settings.intervalMinutes,
          isLoading: false,
        ),
      );

      if (settings.enabled) {
        await _service.scheduleReminder(
          intervalMinutes: settings.intervalMinutes,
        );
      }
    } on Object catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: 'Failed to load reminder settings: $e',
        ),
      );
    }
  }

  Future<void> _onToggleEnabled(
    PeriodicReminderToggleEnabled event,
    Emitter<PeriodicReminderState> emit,
  ) async {
    if (event.enabled == state.enabled) return;

    final previousState = state;
    emit(state.copyWith(enabled: event.enabled, isLoading: true));

    try {
      await _repository.setEnabled(enabled: event.enabled);

      if (event.enabled) {
        await _service.scheduleReminder(intervalMinutes: state.intervalMinutes);
      } else {
        await _service.cancelReminder();
      }

      emit(state.copyWith(isLoading: false));
    } on Object catch (e) {
      debugPrint('Error toggling periodic reminder: $e');
      emit(previousState.copyWith(error: 'Failed to update reminder: $e'));
    }
  }

  Future<void> _onSetInterval(
    PeriodicReminderSetInterval event,
    Emitter<PeriodicReminderState> emit,
  ) async {
    if (event.minutes == state.intervalMinutes ||
        !PeriodicReminderConstants.availableIntervals.contains(event.minutes)) {
      return;
    }

    final previousState = state;
    emit(state.copyWith(intervalMinutes: event.minutes, isLoading: true));

    try {
      await _repository.setIntervalMinutes(event.minutes);

      if (state.enabled) {
        await _service.rescheduleReminder(intervalMinutes: event.minutes);
      }

      emit(state.copyWith(isLoading: false));
    } on Object catch (e) {
      debugPrint('Error changing reminder interval: $e');
      emit(previousState.copyWith(error: 'Failed to update interval: $e'));
    }
  }

  Future<void> _onRescheduleIfEnabled(
    PeriodicReminderRescheduleIfEnabled event,
    Emitter<PeriodicReminderState> emit,
  ) async {
    if (!state.enabled) return;

    try {
      final isScheduled = await _service.isReminderScheduled();
      if (!isScheduled) {
        await _service.scheduleReminder(intervalMinutes: state.intervalMinutes);
      }
    } on Object catch (e) {
      debugPrint('Error rescheduling periodic reminder: $e');
    }
  }

  Future<void> _onCancelAndReset(
    PeriodicReminderCancelAndReset event,
    Emitter<PeriodicReminderState> emit,
  ) async {
    try {
      await _service.cancelReminder();
      await _repository.setEnabled(enabled: false);
      emit(const PeriodicReminderState());
    } on Object catch (e) {
      debugPrint('Error cancelling periodic reminder: $e');
      emit(state.copyWith(error: 'Failed to cancel reminder: $e'));
    }
  }

  Future<void> _onRefresh(
    PeriodicReminderRefresh event,
    Emitter<PeriodicReminderState> emit,
  ) async {
    add(const PeriodicReminderEvent.loadSettings());
  }

  // Convenience methods
  Future<void> toggleEnabled({required bool enabled}) async =>
      add(PeriodicReminderEvent.toggleEnabled(enabled: enabled));

  Future<void> setInterval(int minutes) async =>
      add(PeriodicReminderEvent.setInterval(minutes));

  Future<void> rescheduleIfEnabled() async =>
      add(const PeriodicReminderEvent.rescheduleIfEnabled());

  Future<void> cancelAndReset() async =>
      add(const PeriodicReminderEvent.cancelAndReset());

  Future<void> refresh() async =>
      add(const PeriodicReminderEvent.refresh());
}

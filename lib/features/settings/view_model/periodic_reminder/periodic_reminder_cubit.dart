import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/service/periodic_reminder_constants.dart';
import '../../../../core/service/periodic_reminder_service.dart';
import '../../service/periodic_reminder_repository.dart';

// ─────────────────────────────────────────────────────────────────────────────
// STATE
// ─────────────────────────────────────────────────────────────────────────────

class PeriodicReminderState extends Equatable {
  const PeriodicReminderState({
    this.enabled = PeriodicReminderConstants.defaultEnabled,
    this.intervalMinutes = PeriodicReminderConstants.defaultIntervalMinutes,
    this.isLoading = false,
    this.error,
  });
  final bool enabled;
  final int intervalMinutes;
  final bool isLoading;
  final String? error;

  PeriodicReminderState copyWith({
    bool? enabled,
    int? intervalMinutes,
    bool? isLoading,
    String? error,
  }) => PeriodicReminderState(
    enabled: enabled ?? this.enabled,
    intervalMinutes: intervalMinutes ?? this.intervalMinutes,
    isLoading: isLoading ?? this.isLoading,
    error: error,
  );

  @override
  List<Object?> get props => [enabled, intervalMinutes, isLoading, error];
}

// ─────────────────────────────────────────────────────────────────────────────
// CUBIT
// ─────────────────────────────────────────────────────────────────────────────

class PeriodicReminderCubit extends Cubit<PeriodicReminderState> {
  PeriodicReminderCubit({
    PeriodicReminderRepository? repository,
    PeriodicReminderService? service,
  }) : _repository = repository ?? PeriodicReminderRepository(),
       _service = service ?? PeriodicReminderService(),
       super(const PeriodicReminderState()) {
    _loadSettings();
  }

  final PeriodicReminderRepository _repository;
  final PeriodicReminderService _service;

  /// Loads saved settings from persistence.
  Future<void> _loadSettings() async {
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

      // If enabled, ensure the notification is scheduled
      if (settings.enabled) {
        await _service.scheduleReminder(
          intervalMinutes: settings.intervalMinutes,
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: 'Failed to load reminder settings: $e',
        ),
      );
    }
  }

  /// Toggles the reminder on/off.
  Future<void> toggleEnabled(bool enabled) async {
    if (enabled == state.enabled) return;

    final previousState = state;
    emit(state.copyWith(enabled: enabled, isLoading: true));

    try {
      await _repository.setEnabled(enabled);

      if (enabled) {
        await _service.scheduleReminder(intervalMinutes: state.intervalMinutes);
      } else {
        await _service.cancelReminder();
      }

      emit(state.copyWith(isLoading: false));
    } catch (e) {
      debugPrint('Error toggling periodic reminder: $e');
      emit(previousState.copyWith(error: 'Failed to update reminder: $e'));
    }
  }

  /// Changes the interval duration.
  Future<void> setInterval(int minutes) async {
    if (minutes == state.intervalMinutes ||
        !PeriodicReminderConstants.availableIntervals.contains(minutes)) {
      return;
    }

    final previousState = state;
    emit(state.copyWith(intervalMinutes: minutes, isLoading: true));

    try {
      await _repository.setIntervalMinutes(minutes);

      // If enabled, reschedule with new interval
      if (state.enabled) {
        await _service.rescheduleReminder(intervalMinutes: minutes);
      }

      emit(state.copyWith(isLoading: false));
    } catch (e) {
      debugPrint('Error changing reminder interval: $e');
      emit(previousState.copyWith(error: 'Failed to update interval: $e'));
    }
  }

  /// Reschedules the reminder (useful for app restart).
  /// Prevents duplicate scheduling by checking if already scheduled.
  Future<void> rescheduleIfEnabled() async {
    if (!state.enabled) return;

    try {
      final isScheduled = await _service.isReminderScheduled();
      if (!isScheduled) {
        await _service.scheduleReminder(intervalMinutes: state.intervalMinutes);
      }
    } catch (e) {
      debugPrint('Error rescheduling periodic reminder: $e');
    }
  }

  /// Cancels all reminders (useful for logout or reset).
  Future<void> cancelAndReset() async {
    try {
      await _service.cancelReminder();
      await _repository.setEnabled(false);
      emit(const PeriodicReminderState());
    } catch (e) {
      debugPrint('Error cancelling periodic reminder: $e');
      emit(state.copyWith(error: 'Failed to cancel reminder: $e'));
    }
  }

  /// Refreshes settings from persistence and reapplies.
  /// Call this when app resumes from background to ensure sync.
  Future<void> refresh() async {
    await _loadSettings();
  }
}

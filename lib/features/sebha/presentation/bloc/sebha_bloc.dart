import 'dart:async';

import 'package:muslim/core/bloc/safe_bloc.dart';

import 'package:muslim/features/sebha/data/models/zikr_model.dart';
import 'package:muslim/features/sebha/domain/entities/zikr_entity.dart';
import 'package:muslim/features/sebha/domain/repositories/sebha_repository.dart';
import 'package:muslim/features/sebha/presentation/bloc/sebha_event.dart';
import 'package:muslim/features/sebha/presentation/bloc/sebha_state.dart';

export 'sebha_event.dart';
export 'sebha_state.dart';

class SebhaBloc extends SafeBloc<SebhaEvent, SebhaState> {
  SebhaBloc({
    required SebhaRepository repository,
  }) : _repository = repository,
       super(SebhaState(customGoal: ZikrModel.defaultAzkar[0].count)) {
    on<SebhaLoadCustomAzkar>(_onLoadCustomAzkar);
    on<SebhaIncrement>(_onIncrement);
    on<SebhaReset>(_onReset);
    on<SebhaConsumeGoalReached>(_onConsumeGoalReached);
    on<SebhaSelectZikr>(_onSelectZikr);
    on<SebhaSetGoal>(_onSetGoal);
    on<SebhaAddCustomZikr>(_onAddCustomZikr);
    on<SebhaEditCustomZikr>(_onEditCustomZikr);
    on<SebhaDeleteCustomZikr>(_onDeleteCustomZikr);
  }

  final SebhaRepository _repository;

  Future<void> _onLoadCustomAzkar(
    SebhaLoadCustomAzkar event,
    Emitter<SebhaState> emit,
  ) async {
    emit(state.copyWith(status: SebhaRequestStatus.loading));
    final result = await _repository.getCustomAzkar();
    result.fold(
      (failure) => emit(state.copyWith(status: SebhaRequestStatus.failure)),
      (customAzkar) => emit(
        state.copyWith(
          status: SebhaRequestStatus.success,
          customAzkar: customAzkar,
        ),
      ),
    );

    final zikr = state.currentZikr;
    if (zikr != null) {
      final saved = await _repository.loadProgress(zikr.id);
      if (saved > 0) emit(state.copyWith(counter: saved));
    }
  }

  void _onIncrement(
    SebhaIncrement event,
    Emitter<SebhaState> emit,
  ) {
    final newCounter = state.counter + 1;
    final goalReached =
        state.customGoal != null && newCounter == state.customGoal;

    emit(state.copyWith(counter: newCounter, goalReached: goalReached));

    final zikr = state.currentZikr;
    if (zikr != null) unawaited(_repository.saveProgress(zikr.id, newCounter));
  }

  void _onReset(
    SebhaReset event,
    Emitter<SebhaState> emit,
  ) {
    emit(state.copyWith(counter: 0, goalReached: false));
    final zikr = state.currentZikr;
    if (zikr != null) unawaited(_repository.saveProgress(zikr.id, 0));
  }

  void _onConsumeGoalReached(
    SebhaConsumeGoalReached event,
    Emitter<SebhaState> emit,
  ) {
    if (state.goalReached) {
      emit(state.copyWith(goalReached: false));
    }
  }

  Future<void> _onSelectZikr(
    SebhaSelectZikr event,
    Emitter<SebhaState> emit,
  ) async {
    final allAzkar = state.allAzkar;
    final goal = event.index < allAzkar.length ? allAzkar[event.index].count : null;

    emit(
      state.copyWith(
        currentIndex: event.index,
        counter: 0,
        goalReached: false,
        customGoal: goal,
      ),
    );

    final zikr = state.currentZikr;
    if (zikr != null) {
      final saved = await _repository.loadProgress(zikr.id);
      if (saved > 0) emit(state.copyWith(counter: saved));
    }
  }

  void _onSetGoal(
    SebhaSetGoal event,
    Emitter<SebhaState> emit,
  ) {
    emit(state.copyWith(customGoal: event.goal, goalReached: false));
  }

  Future<void> _onAddCustomZikr(
    SebhaAddCustomZikr event,
    Emitter<SebhaState> emit,
  ) async {
    final result = await _repository.saveCustomZikr(event.zikr);
    await result.fold((failure) => null, (success) async {
      if (success) {
        add(const SebhaEvent.loadCustomAzkar());
      }
    });
  }

  Future<void> _onEditCustomZikr(
    SebhaEditCustomZikr event,
    Emitter<SebhaState> emit,
  ) async {
    final result = await _repository.updateCustomZikr(event.zikr);
    await result.fold((failure) => null, (success) async {
      if (success) {
        add(const SebhaEvent.loadCustomAzkar());

        final allAzkar = state.allAzkar;
        final currentIndex = state.currentIndex;
        if (currentIndex < allAzkar.length &&
            allAzkar[currentIndex].id == event.zikr.id) {
          emit(state.copyWith(customGoal: event.zikr.count));
        }
      }
    });
  }

  Future<void> _onDeleteCustomZikr(
    SebhaDeleteCustomZikr event,
    Emitter<SebhaState> emit,
  ) async {
    final allAzkar = state.allAzkar;
    final currentIndex = state.currentIndex;

    final wasSelected =
        currentIndex < allAzkar.length && allAzkar[currentIndex].id == event.id;

    final result = await _repository.deleteCustomZikr(event.id);
    await result.fold((failure) => null, (success) async {
      if (success) {
        await _repository.saveProgress(event.id, 0);
        add(const SebhaEvent.loadCustomAzkar());

        if (wasSelected) {
          emit(
            state.copyWith(
              currentIndex: 0,
              counter: 0,
              goalReached: false,
              customGoal: ZikrModel.defaultAzkar[0].count,
            ),
          );
        }
      }
    });
  }

  // Convenience methods
  Future<void> loadCustomAzkar() async => safeAdd(const SebhaEvent.loadCustomAzkar());
  void increment() => safeAdd(const SebhaEvent.increment());
  void reset() => safeAdd(const SebhaEvent.reset());
  void consumeGoalReached() => safeAdd(const SebhaEvent.consumeGoalReached());
  Future<void> selectZikr(int index) async => safeAdd(SebhaEvent.selectZikr(index));
  void setGoal(int? goal) => safeAdd(SebhaEvent.setGoal(goal));
  Future<void> addCustomZikr(ZikrEntity zikr) async => safeAdd(SebhaEvent.addCustomZikr(zikr));
  Future<void> editCustomZikr(ZikrEntity zikr) async => safeAdd(SebhaEvent.editCustomZikr(zikr));
  Future<void> deleteCustomZikr(String id) async => safeAdd(SebhaEvent.deleteCustomZikr(id));
}

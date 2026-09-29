import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:muslim/features/sebha/data/models/zikr_model.dart';
import 'package:muslim/features/sebha/domain/entities/zikr_entity.dart';
import 'package:muslim/features/sebha/domain/repositories/sebha_repository.dart';
import 'package:muslim/features/sebha/presentation/cubit/sebha_state.dart';

class SebhaCubit extends Cubit<SebhaState> {
  SebhaCubit({
    required SebhaRepository repository,
  }) : _repository = repository,
       super(SebhaState(customGoal: ZikrModel.defaultAzkar[0].count));

  final SebhaRepository _repository;

  Future<void> loadCustomAzkar() async {
    if (isClosed) return;
    emit(state.copyWith(status: SebhaRequestStatus.loading));
    final result = await _repository.getCustomAzkar();
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(status: SebhaRequestStatus.failure)),
      (customAzkar) => emit(
        state.copyWith(
          status: SebhaRequestStatus.success,
          customAzkar: customAzkar,
        ),
      ),
    );
    // Load saved progress for the currently selected zikr after azkar load
    await _loadCurrentProgress();
  }

  Future<void> _loadCurrentProgress() async {
    final zikr = state.currentZikr;
    if (zikr == null) return;
    final saved = await _repository.loadProgress(zikr.id);
    if (isClosed) return;
    if (saved > 0) emit(state.copyWith(counter: saved));
  }

  void increment() {
    final newCounter = state.counter + 1;
    final goalReached =
        state.customGoal != null && newCounter == state.customGoal;

    emit(state.copyWith(counter: newCounter, goalReached: goalReached));

    // ponytail: fire-and-forget — SP writes are fast, no debounce needed
    final zikr = state.currentZikr;
    if (zikr != null) unawaited(_repository.saveProgress(zikr.id, newCounter));
  }

  void consumeGoalReached() {
    if (state.goalReached && !isClosed) {
      emit(state.copyWith(goalReached: false));
    }
  }

  void reset() {
    emit(state.copyWith(counter: 0, goalReached: false));
    // Clear saved progress on manual reset
    final zikr = state.currentZikr;
    if (zikr != null) unawaited(_repository.saveProgress(zikr.id, 0));
  }

  Future<void> selectZikr(int index) async {
    final allAzkar = state.allAzkar;
    final goal = index < allAzkar.length ? allAzkar[index].count : null;

    if (isClosed) return;
    emit(
      state.copyWith(
        currentIndex: index,
        counter: 0,
        goalReached: false,
        customGoal: () => goal,
      ),
    );

    // Load persisted progress for the newly selected zikr
    final zikr = state.currentZikr;
    if (zikr != null) {
      final saved = await _repository.loadProgress(zikr.id);
      if (isClosed) return;
      if (saved > 0) emit(state.copyWith(counter: saved));
    }
  }

  void setGoal(int? goal) {
    if (isClosed) return;
    emit(state.copyWith(customGoal: () => goal, goalReached: false));
  }

  Future<void> addCustomZikr(ZikrEntity zikr) async {
    final result = await _repository.saveCustomZikr(zikr);
    if (isClosed) return;
    await result.fold((failure) => null, (success) async {
      if (success && !isClosed) {
        await loadCustomAzkar();
      }
    });
  }

  Future<void> editCustomZikr(ZikrEntity zikr) async {
    final result = await _repository.updateCustomZikr(zikr);
    if (isClosed) return;
    await result.fold((failure) => null, (success) async {
      if (success && !isClosed) {
        await loadCustomAzkar();

        final allAzkar = state.allAzkar;
        final currentIndex = state.currentIndex;
        if (currentIndex < allAzkar.length &&
            allAzkar[currentIndex].id == zikr.id &&
            !isClosed) {
          emit(state.copyWith(customGoal: () => zikr.count));
        }
      }
    });
  }

  Future<void> deleteCustomZikr(String id) async {
    final allAzkar = state.allAzkar;
    final currentIndex = state.currentIndex;

    final wasSelected =
        currentIndex < allAzkar.length && allAzkar[currentIndex].id == id;

    final result = await _repository.deleteCustomZikr(id);
    if (isClosed) return;
    await result.fold((failure) => null, (success) async {
      if (success && !isClosed) {
        // Clear progress for deleted zikr
        await _repository.saveProgress(id, 0);
        await loadCustomAzkar();

        if (wasSelected && !isClosed) {
          emit(
            state.copyWith(
              currentIndex: 0,
              counter: 0,
              goalReached: false,
              customGoal: () => ZikrModel.defaultAzkar[0].count,
            ),
          );
        }
      }
    });
  }
}

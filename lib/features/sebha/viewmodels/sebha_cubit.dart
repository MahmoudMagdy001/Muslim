import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/zikr_model.dart';
import '../repositories/sebha_repository.dart';
import 'sebha_state.dart';

class SebhaCubit extends Cubit<SebhaState> {
  SebhaCubit({required SebhaRepository repository})
    : _repository = repository,
      super(SebhaState(customGoal: ZikrModel.defaultAzkar[0].count));

  final SebhaRepository _repository;

  Future<void> loadCustomAzkar() async {
    emit(state.copyWith(status: SebhaRequestStatus.loading));
    try {
      final customAzkar = await _repository.getCustomAzkar();
      emit(
        state.copyWith(
          status: SebhaRequestStatus.success,
          customAzkar: customAzkar,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: SebhaRequestStatus.failure));
    }
  }

  void increment() {
    final newCounter = state.counter + 1;
    final goalReached =
        state.customGoal != null && newCounter == state.customGoal;

    emit(state.copyWith(counter: newCounter, goalReached: goalReached));

    // Reset goalReached flag so listener only fires once
    if (goalReached) {
      emit(state.copyWith(goalReached: false));
    }
  }

  void reset() {
    emit(state.copyWith(counter: 0));
  }

  void selectZikr(int index) {
    final allAzkar = state.allAzkar;
    final goal = index < allAzkar.length ? allAzkar[index].count : null;

    emit(
      state.copyWith(currentIndex: index, counter: 0, customGoal: () => goal),
    );
  }

  void setGoal(int? goal) {
    emit(state.copyWith(customGoal: () => goal));
  }

  Future<void> addCustomZikr(ZikrModel zikr) async {
    final success = await _repository.saveCustomZikr(zikr);
    if (success) {
      await loadCustomAzkar();
    }
  }

  Future<void> editCustomZikr(ZikrModel zikr) async {
    final success = await _repository.updateCustomZikr(zikr);
    if (success) {
      await loadCustomAzkar();

      // If the edited zikr is currently selected, update the goal
      final allAzkar = state.allAzkar;
      final currentIndex = state.currentIndex;
      if (currentIndex < allAzkar.length &&
          allAzkar[currentIndex].id == zikr.id) {
        emit(state.copyWith(customGoal: () => zikr.count));
      }
    }
  }

  Future<void> deleteCustomZikr(String id) async {
    final allAzkar = state.allAzkar;
    final currentIndex = state.currentIndex;

    // Track if the deleted zikr was selected
    final wasSelected =
        currentIndex < allAzkar.length && allAzkar[currentIndex].id == id;

    final success = await _repository.deleteCustomZikr(id);
    if (success) {
      await loadCustomAzkar();

      // If deleted zikr was selected, reset to first
      if (wasSelected) {
        emit(
          state.copyWith(
            currentIndex: 0,
            counter: 0,
            customGoal: () => ZikrModel.defaultAzkar[0].count,
          ),
        );
      }
    }
  }
}

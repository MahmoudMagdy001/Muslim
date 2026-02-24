import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/usecase.dart';
import '../../data/models/zikr_model.dart';
import '../../domain/entities/zikr_entity.dart';
import '../../domain/usecases/delete_custom_zikr_use_case.dart';
import '../../domain/usecases/get_custom_azkar_use_case.dart';
import '../../domain/usecases/save_custom_zikr_use_case.dart';
import '../../domain/usecases/update_custom_zikr_use_case.dart';
import 'sebha_state.dart';

class SebhaCubit extends Cubit<SebhaState> {
  SebhaCubit({
    required GetCustomAzkarUseCase getCustomAzkarUseCase,
    required SaveCustomZikrUseCase saveCustomZikrUseCase,
    required UpdateCustomZikrUseCase updateCustomZikrUseCase,
    required DeleteCustomZikrUseCase deleteCustomZikrUseCase,
  }) : _getCustomAzkarUseCase = getCustomAzkarUseCase,
       _saveCustomZikrUseCase = saveCustomZikrUseCase,
       _updateCustomZikrUseCase = updateCustomZikrUseCase,
       _deleteCustomZikrUseCase = deleteCustomZikrUseCase,
       super(SebhaState(customGoal: ZikrModel.defaultAzkar[0].count));

  final GetCustomAzkarUseCase _getCustomAzkarUseCase;
  final SaveCustomZikrUseCase _saveCustomZikrUseCase;
  final UpdateCustomZikrUseCase _updateCustomZikrUseCase;
  final DeleteCustomZikrUseCase _deleteCustomZikrUseCase;

  Future<void> loadCustomAzkar() async {
    emit(state.copyWith(status: SebhaRequestStatus.loading));
    final result = await _getCustomAzkarUseCase(NoParams());
    result.fold(
      (failure) => emit(state.copyWith(status: SebhaRequestStatus.failure)),
      (customAzkar) => emit(
        state.copyWith(
          status: SebhaRequestStatus.success,
          customAzkar: customAzkar,
        ),
      ),
    );
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

  Future<void> addCustomZikr(ZikrEntity zikr) async {
    final result = await _saveCustomZikrUseCase(zikr);
    result.fold((failure) => null, (success) async {
      if (success) {
        await loadCustomAzkar();
      }
    });
  }

  Future<void> editCustomZikr(ZikrEntity zikr) async {
    final result = await _updateCustomZikrUseCase(zikr);
    result.fold((failure) => null, (success) async {
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
    });
  }

  Future<void> deleteCustomZikr(String id) async {
    final allAzkar = state.allAzkar;
    final currentIndex = state.currentIndex;

    // Track if the deleted zikr was selected
    final wasSelected =
        currentIndex < allAzkar.length && allAzkar[currentIndex].id == id;

    final result = await _deleteCustomZikrUseCase(id);
    result.fold((failure) => null, (success) async {
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
    });
  }
}

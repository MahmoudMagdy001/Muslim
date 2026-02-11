import 'package:flutter_bloc/flutter_bloc.dart';

import '../../prayer_times/viewmodel/prayer_times_state.dart';
import '../models/azkar_model.dart';
import '../repositories/azkar_repository.dart';
import '../services/azkar_persistence_service.dart';
import 'azkar_state.dart';

class AzkarCubit extends Cubit<AzkarState> {
  AzkarCubit(this._repository, this._persistenceService)
    : super(const AzkarState());
  final AzkarRepository _repository;
  final AzkarPersistenceService _persistenceService;

  Future<void> loadAzkar() async {
    emit(state.copyWith(status: RequestStatus.loading));
    try {
      final azkar = await _repository.getAzkarList();

      // Group by category
      final Map<String, List<AzkarModel>> grouped = {};
      for (var item in azkar) {
        if (!grouped.containsKey(item.category)) {
          grouped[item.category] = [];
        }
        grouped[item.category]!.add(item);
      }

      emit(
        state.copyWith(
          status: RequestStatus.success,
          azkarList: azkar,
          groupedAzkar: grouped,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: RequestStatus.failure, message: e.toString()),
      );
    }
  }

  Future<void> loadAzkarContent(String url) async {
    emit(
      state.copyWith(contentStatus: RequestStatus.loading, currentContent: []),
    );
    try {
      await _persistenceService.clearIfNewDay();
      final content = await _repository.getAzkarContent(url);

      // Initialize counts based on repetition or saved progress
      final Map<int, int> counts = {};
      for (int i = 0; i < content.length; i++) {
        final savedCount = await _persistenceService.getCount(url, i);
        counts[i] = savedCount ?? content[i].repeat;
      }

      emit(
        state.copyWith(
          contentStatus: RequestStatus.success,
          currentContent: content,
          currentCounts: counts,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          contentStatus: RequestStatus.failure,
          message: e.toString(),
        ),
      );
    }
  }

  void decrementCount(String url, int index) {
    final counts = Map<int, int>.from(state.currentCounts);
    if (counts.containsKey(index) && counts[index]! > 0) {
      counts[index] = counts[index]! - 1;
      _persistenceService.saveCount(url, index, counts[index]!);
      emit(state.copyWith(currentCounts: counts));
    }
  }

  void resetCount(String url, int index) {
    final counts = Map<int, int>.from(state.currentCounts);
    if (index < state.currentContent.length) {
      counts[index] = state.currentContent[index].repeat;
      _persistenceService.saveCount(url, index, counts[index]!);
      emit(state.copyWith(currentCounts: counts));
    }
  }
}

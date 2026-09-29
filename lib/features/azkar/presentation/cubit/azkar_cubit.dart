import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim/features/azkar/domain/entities/azkar_entity.dart';
import 'package:muslim/features/azkar/domain/repositories/azkar_repository.dart';
import 'package:muslim/features/azkar/presentation/cubit/azkar_state.dart';
import 'package:muslim/features/prayer_times/presentation/cubit/prayer_times_state.dart';

class AzkarCubit extends Cubit<AzkarState> {
  AzkarCubit(this._repository) : super(const AzkarState());

  final AzkarRepository _repository;

  Future<void> loadAzkar() async {
    if (isClosed) return;
    emit(state.copyWith(status: RequestStatus.loading));

    final result = await _repository.getAzkarList();
    if (isClosed) return;

    result.fold(
      (failure) {
        if (!isClosed) {
          emit(
            state.copyWith(
              status: RequestStatus.failure,
              message: failure.properties.isNotEmpty
                  ? failure.properties.first.toString()
                  : 'Unexpected error',
            ),
          );
        }
      },
      (azkar) {
        // Group by category
        final grouped = <String, List<AzkarEntity>>{};
        for (final item in azkar) {
          if (!grouped.containsKey(item.category)) {
            grouped[item.category] = [];
          }
          grouped[item.category]!.add(item);
        }

        if (!isClosed) {
          emit(
            state.copyWith(
              status: RequestStatus.success,
              azkarList: azkar,
              groupedAzkar: grouped,
            ),
          );
        }
      },
    );
  }

  Future<void> loadAzkarContent(String url) async {
    if (isClosed) return;
    emit(
      state.copyWith(
        contentStatus: RequestStatus.loading,
        currentContent: [],
      ),
    );

    await _repository.clearAzkarCountIfNewDay();
    if (isClosed) return;

    final result = await _repository.getAzkarContent(url);
    if (isClosed) return;

    await result.fold(
      (failure) async {
        if (!isClosed) {
          emit(
            state.copyWith(
              contentStatus: RequestStatus.failure,
              message: failure.properties.isNotEmpty
                  ? failure.properties.first.toString()
                  : 'Unexpected error',
            ),
          );
        }
      },
      (content) async {
        // Optimized: Load all counts in parallel instead of sequential awaits
        final counts = <int, int>{};
        final countFutures = <Future<void>>[];

        for (var i = 0; i < content.length; i++) {
          countFutures.add(
            _repository.getAzkarCount(url, i).then((countResult) {
              var savedCount = content[i].repeat;
              countResult.fold((l) => null, (r) {
                if (r != null) {
                  savedCount = r;
                }
              });
              counts[i] = savedCount;
            }),
          );
        }

        // Wait for all count queries to complete in parallel
        await Future.wait(countFutures);

        if (!isClosed) {
          emit(
            state.copyWith(
              contentStatus: RequestStatus.success,
              currentContent: content,
              currentCounts: counts,
            ),
          );
        }
      },
    );
  }

  Future<void> decrementCount(String url, int index) async {
    final counts = Map<int, int>.from(state.currentCounts);
    if (counts.containsKey(index) && counts[index]! > 0) {
      final newCount = counts[index]! - 1;
      counts[index] = newCount;
      if (!isClosed) emit(state.copyWith(currentCounts: counts));
      await _repository.saveAzkarCount(url, index, newCount);
    }
  }

  Future<void> resetCount(String url, int index) async {
    final counts = Map<int, int>.from(state.currentCounts);
    if (index < state.currentContent.length) {
      final resetVal = state.currentContent[index].repeat;
      counts[index] = resetVal;
      if (!isClosed) emit(state.copyWith(currentCounts: counts));
      await _repository.saveAzkarCount(url, index, resetVal);
    }
  }
}

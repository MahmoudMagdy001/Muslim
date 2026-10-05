import 'package:muslim/core/bloc/safe_bloc.dart';
import 'package:muslim/features/azkar/domain/entities/azkar_entity.dart';
import 'package:muslim/features/azkar/domain/repositories/azkar_repository.dart';
import 'package:muslim/features/azkar/presentation/bloc/azkar_event.dart';
import 'package:muslim/features/azkar/presentation/bloc/azkar_state.dart';
import 'package:muslim/features/prayer_times/presentation/bloc/prayer_times_state.dart';

export 'azkar_event.dart';
export 'azkar_state.dart';

class AzkarBloc extends SafeBloc<AzkarEvent, AzkarState> {
  AzkarBloc(this._repository) : super(const AzkarState()) {
    on<AzkarLoadAzkar>(_onLoadAzkar);
    on<AzkarLoadAzkarContent>(_onLoadAzkarContent);
    on<AzkarDecrementCount>(_onDecrementCount);
    on<AzkarResetCount>(_onResetCount);
  }

  final AzkarRepository _repository;

  Future<void> _onLoadAzkar(
    AzkarLoadAzkar event,
    Emitter<AzkarState> emit,
  ) async {
    emit(state.copyWith(status: RequestStatus.loading));

    final result = await _repository.getAzkarList();

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: RequestStatus.failure,
            message: failure.properties.isNotEmpty
                ? failure.properties.first.toString()
                : 'Unexpected error',
          ),
        );
      },
      (azkar) {
        final grouped = <String, List<AzkarEntity>>{};
        for (final item in azkar) {
          grouped.putIfAbsent(item.category, () => []).add(item);
        }

        emit(
          state.copyWith(
            status: RequestStatus.success,
            azkarList: azkar,
            groupedAzkar: grouped,
          ),
        );
      },
    );
  }

  Future<void> _onLoadAzkarContent(
    AzkarLoadAzkarContent event,
    Emitter<AzkarState> emit,
  ) async {
    emit(
      state.copyWith(
        contentStatus: RequestStatus.loading,
        currentContent: [],
      ),
    );

    await _repository.clearAzkarCountIfNewDay();

    final result = await _repository.getAzkarContent(event.url);

    await result.fold(
      (failure) async {
        emit(
          state.copyWith(
            contentStatus: RequestStatus.failure,
            message: failure.properties.isNotEmpty
                ? failure.properties.first.toString()
                : 'Unexpected error',
          ),
        );
      },
      (content) async {
        final counts = <int, int>{};
        final countFutures = <Future<void>>[];

        for (var i = 0; i < content.length; i++) {
          countFutures.add(
            _repository.getAzkarCount(event.url, i).then((countResult) {
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

        await Future.wait(countFutures);

        emit(
          state.copyWith(
            contentStatus: RequestStatus.success,
            currentContent: content,
            currentCounts: counts,
          ),
        );
      },
    );
  }

  Future<void> _onDecrementCount(
    AzkarDecrementCount event,
    Emitter<AzkarState> emit,
  ) async {
    final counts = Map<int, int>.from(state.currentCounts);
    final currentCount = counts[event.index];
    if (currentCount != null && currentCount > 0) {
      final newCount = currentCount - 1;
      counts[event.index] = newCount;
      emit(state.copyWith(currentCounts: counts));
      await _repository.saveAzkarCount(event.url, event.index, newCount);
    }
  }

  Future<void> _onResetCount(
    AzkarResetCount event,
    Emitter<AzkarState> emit,
  ) async {
    final counts = Map<int, int>.from(state.currentCounts);
    if (event.index < state.currentContent.length) {
      final resetVal = state.currentContent[event.index].repeat;
      counts[event.index] = resetVal;
      emit(state.copyWith(currentCounts: counts));
      await _repository.saveAzkarCount(event.url, event.index, resetVal);
    }
  }

  // Convenience methods
  Future<void> loadAzkar() async => safeAdd(const AzkarEvent.loadAzkar());
  Future<void> loadAzkarContent(String url) async =>
      safeAdd(AzkarEvent.loadAzkarContent(url));
  Future<void> decrementCount(String url, int index) async =>
      safeAdd(AzkarEvent.decrementCount(url, index));
  Future<void> resetCount(String url, int index) async =>
      safeAdd(AzkarEvent.resetCount(url, index));
}

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../prayer_times/presentation/cubit/prayer_times_state.dart';
import '../../domain/entities/azkar_entity.dart';
import '../../domain/usecases/clear_azkar_count_usecase.dart';
import '../../domain/usecases/get_azkar_content_usecase.dart';
import '../../domain/usecases/get_azkar_count_usecase.dart';
import '../../domain/usecases/get_azkar_list_usecase.dart';
import '../../domain/usecases/save_azkar_count_usecase.dart';
import 'azkar_state.dart';

class AzkarCubit extends Cubit<AzkarState> {
  AzkarCubit(
    this._getAzkarListUseCase,
    this._getAzkarContentUseCase,
    this._saveAzkarCountUseCase,
    this._getAzkarCountUseCase,
    this._clearAzkarCountUseCase,
  ) : super(const AzkarState());

  final GetAzkarListUseCase _getAzkarListUseCase;
  final GetAzkarContentUseCase _getAzkarContentUseCase;
  final SaveAzkarCountUseCase _saveAzkarCountUseCase;
  final GetAzkarCountUseCase _getAzkarCountUseCase;
  final ClearAzkarCountUseCase _clearAzkarCountUseCase;

  Future<void> loadAzkar() async {
    if (!isClosed) emit(state.copyWith(status: RequestStatus.loading));

    final result = await _getAzkarListUseCase(NoParams());

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
        final Map<String, List<AzkarEntity>> grouped = {};
        for (var item in azkar) {
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
    if (!isClosed) {
      emit(
        state.copyWith(
          contentStatus: RequestStatus.loading,
          currentContent: [],
        ),
      );
    }

    await _clearAzkarCountUseCase(NoParams());

    final result = await _getAzkarContentUseCase(
      GetAzkarContentParams(url: url),
    );

    result.fold(
      (failure) {
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
        // Initialize counts based on repetition or saved progress
        final Map<int, int> counts = {};
        for (int i = 0; i < content.length; i++) {
          final countResult = await _getAzkarCountUseCase(
            GetAzkarCountParams(sourceUrl: url, index: i),
          );

          int savedCount = content[i].repeat;
          countResult.fold((l) => null, (r) {
            if (r != null) {
              savedCount = r;
            }
          });

          counts[i] = savedCount;
        }

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
      counts[index] = counts[index]! - 1;
      await _saveAzkarCountUseCase(
        SaveAzkarCountParams(
          sourceUrl: url,
          index: index,
          count: counts[index]!,
        ),
      );
      if (!isClosed) emit(state.copyWith(currentCounts: counts));
    }
  }

  Future<void> resetCount(String url, int index) async {
    final counts = Map<int, int>.from(state.currentCounts);
    if (index < state.currentContent.length) {
      counts[index] = state.currentContent[index].repeat;
      await _saveAzkarCountUseCase(
        SaveAzkarCountParams(
          sourceUrl: url,
          index: index,
          count: counts[index]!,
        ),
      );
      if (!isClosed) emit(state.copyWith(currentCounts: counts));
    }
  }
}

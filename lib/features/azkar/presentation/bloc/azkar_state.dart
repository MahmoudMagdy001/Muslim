import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:muslim/features/azkar/domain/entities/azkar_entity.dart';
import 'package:muslim/features/prayer_times/presentation/bloc/prayer_times_state.dart';

part 'azkar_state.freezed.dart';

@freezed
abstract class AzkarState with _$AzkarState {
  const factory AzkarState({
    @Default(RequestStatus.initial) RequestStatus status,
    @Default(RequestStatus.initial) RequestStatus contentStatus,
    @Default([]) List<AzkarEntity> azkarList,
    @Default({}) Map<String, List<AzkarEntity>> groupedAzkar,
    @Default([]) List<AzkarContentEntity> currentContent,
    @Default({}) Map<int, int> currentCounts,
    String? message,
  }) = _AzkarState;
}

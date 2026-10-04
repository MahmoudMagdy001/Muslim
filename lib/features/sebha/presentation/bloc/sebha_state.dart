import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:muslim/features/sebha/domain/entities/zikr_entity.dart';

part 'sebha_state.freezed.dart';

enum SebhaRequestStatus { initial, loading, success, failure }

@freezed
abstract class SebhaState with _$SebhaState {
  const SebhaState._();

  const factory SebhaState({
    @Default(SebhaRequestStatus.initial) SebhaRequestStatus status,
    @Default(0) int counter,
    @Default(0) int currentIndex,
    @Default(false) bool goalReached,
    int? customGoal,
    @Default([]) List<ZikrEntity> customAzkar,
  }) = _SebhaState;

  List<ZikrEntity> get allAzkar => [
    ...ZikrEntity.defaultAzkar,
    ...customAzkar,
  ];

  ZikrEntity? get currentZikr {
    final azkar = allAzkar;
    if (currentIndex < azkar.length) {
      return azkar[currentIndex];
    }
    return null;
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:muslim/features/hadith/domain/entities/hadith_entity.dart';

part 'hadith_state.freezed.dart';

enum HadithStatus { initial, loading, success, error }

@freezed
abstract class HadithState with _$HadithState {
  const factory HadithState({
    @Default(HadithStatus.initial) HadithStatus status,
    @Default([]) List<HadithEntity> hadiths,
    @Default([]) List<Map<String, dynamic>> savedHadiths,
    @Default({}) Set<String> savedHadithIds,
    @Default(false) bool dataLoaded,
    String? message,
  }) = _HadithState;
}

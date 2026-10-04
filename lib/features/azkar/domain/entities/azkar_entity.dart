import 'package:freezed_annotation/freezed_annotation.dart';

part 'azkar_entity.freezed.dart';

@freezed
abstract class AzkarEntity with _$AzkarEntity {
  const factory AzkarEntity({
    required int id,
    required String title,
    required String engTitle,
    required String slug,
    required bool isFavorite,
    required String category,
    required String audioUrl,
    required String textUrl,
  }) = _AzkarEntity;
}

@freezed
abstract class AzkarContentEntity with _$AzkarContentEntity {
  const factory AzkarContentEntity({
    required int id,
    required String arabicText,
    required String translatedText,
    required int repeat,
    required String audio,
  }) = _AzkarContentEntity;
}

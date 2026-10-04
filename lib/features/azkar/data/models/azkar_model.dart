import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:muslim/features/azkar/domain/entities/azkar_entity.dart';

part 'azkar_model.freezed.dart';

@Freezed(toJson: false, fromJson: false)
abstract class AzkarModel with _$AzkarModel {
  const AzkarModel._();

  const factory AzkarModel({
    required int id,
    required String title,
    @Default('') String engTitle,
    @Default('') String slug,
    @Default(false) bool isFavorite,
    @Default('General') String category,
    @Default('') String audioUrl,
    @Default('') String textUrl,
  }) = _AzkarModel;

  factory AzkarModel.fromJson(Map<String, dynamic> json) => AzkarModel(
    id: json['ID'] as int,
    title: json['TITLE'] as String,
    engTitle: json['eng_title'] as String? ?? '',
    slug: json['slug'] as String? ?? '',
    isFavorite: json['isFavorite'] as bool? ?? false,
    category: json['CATEGORY'] as String? ?? 'General',
    audioUrl: json['AUDIO_URL'] as String? ?? '',
    textUrl: json['TEXT'] as String? ?? '',
  );

  AzkarEntity toEntity() => AzkarEntity(
    id: id,
    title: title,
    engTitle: engTitle,
    slug: slug,
    isFavorite: isFavorite,
    category: category,
    audioUrl: audioUrl,
    textUrl: textUrl,
  );
}

@Freezed(toJson: false, fromJson: false)
abstract class AzkarContentModel with _$AzkarContentModel {
  const AzkarContentModel._();

  const factory AzkarContentModel({
    required int id,
    @Default('') String arabicText,
    @Default('') String translatedText,
    @Default(1) int repeat,
    @Default('') String audio,
  }) = _AzkarContentModel;

  factory AzkarContentModel.fromJson(Map<String, dynamic> json) =>
      AzkarContentModel(
        id: json['ID'] as int,
        arabicText: json['ARABIC_TEXT'] as String? ?? '',
        translatedText: json['TRANSLATED_TEXT'] as String? ?? '',
        repeat: json['REPEAT'] as int? ?? 1,
        audio: json['AUDIO'] as String? ?? '',
      );

  AzkarContentEntity toEntity() => AzkarContentEntity(
    id: id,
    arabicText: arabicText,
    translatedText: translatedText,
    repeat: repeat,
    audio: audio,
  );
}

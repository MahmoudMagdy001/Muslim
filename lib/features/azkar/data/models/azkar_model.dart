import '../../domain/entities/azkar_entity.dart';

class AzkarModel extends AzkarEntity {
  const AzkarModel({
    required super.id,
    required super.title,
    required super.engTitle,
    required super.slug,
    required super.isFavorite,
    required super.category,
    required super.audioUrl,
    required super.textUrl,
  });

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
}

class AzkarContentModel extends AzkarContentEntity {
  const AzkarContentModel({
    required super.id,
    required super.arabicText,
    required super.translatedText,
    required super.repeat,
    required super.audio,
  });

  factory AzkarContentModel.fromJson(Map<String, dynamic> json) =>
      AzkarContentModel(
        id: json['ID'] as int,
        arabicText: json['ARABIC_TEXT'] as String? ?? '',
        translatedText: json['TRANSLATED_TEXT'] as String? ?? '',
        repeat: json['REPEAT'] as int? ?? 1,
        audio: json['AUDIO'] as String? ?? '',
      );
}

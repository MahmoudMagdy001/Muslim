import 'package:equatable/equatable.dart';

class AzkarModel extends Equatable {
  const AzkarModel({
    required this.id,
    required this.title,
    required this.engTitle,
    required this.slug,
    required this.isFavorite,
    required this.category,
    required this.audioUrl,
    required this.textUrl,
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
  final int id;
  final String title;
  final String engTitle;
  final String slug;
  final bool isFavorite;
  final String category;
  final String audioUrl;
  final String textUrl;

  @override
  List<Object?> get props => [
    id,
    title,
    engTitle,
    slug,
    isFavorite,
    category,
    audioUrl,
    textUrl,
  ];
}

class AzkarContentModel extends Equatable {
  const AzkarContentModel({
    required this.id,
    required this.arabicText,
    required this.translatedText,
    required this.repeat,
    required this.audio,
  });

  factory AzkarContentModel.fromJson(Map<String, dynamic> json) =>
      AzkarContentModel(
        id: json['ID'] as int,
        arabicText: json['ARABIC_TEXT'] as String? ?? '',
        translatedText: json['TRANSLATED_TEXT'] as String? ?? '',
        repeat: json['REPEAT'] as int? ?? 1,
        audio: json['AUDIO'] as String? ?? '',
      );
  final int id;
  final String arabicText;
  final String translatedText;
  final int repeat;
  final String audio;

  @override
  List<Object?> get props => [id, arabicText, translatedText, repeat, audio];
}

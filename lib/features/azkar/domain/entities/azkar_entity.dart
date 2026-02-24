import 'package:equatable/equatable.dart';

class AzkarEntity extends Equatable {
  const AzkarEntity({
    required this.id,
    required this.title,
    required this.engTitle,
    required this.slug,
    required this.isFavorite,
    required this.category,
    required this.audioUrl,
    required this.textUrl,
  });

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

class AzkarContentEntity extends Equatable {
  const AzkarContentEntity({
    required this.id,
    required this.arabicText,
    required this.translatedText,
    required this.repeat,
    required this.audio,
  });

  final int id;
  final String arabicText;
  final String translatedText;
  final int repeat;
  final String audio;

  @override
  List<Object?> get props => [id, arabicText, translatedText, repeat, audio];
}

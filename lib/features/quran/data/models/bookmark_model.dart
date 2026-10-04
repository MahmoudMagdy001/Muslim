import 'package:freezed_annotation/freezed_annotation.dart';

part 'bookmark_model.freezed.dart';

@Freezed(toJson: false, fromJson: false)
abstract class AyahBookmark with _$AyahBookmark {
  const AyahBookmark._();

  const factory AyahBookmark({
    required int surahNumber,
    required int ayahNumber,
    required int timestampMs,
    required String ayahText,
  }) = _AyahBookmark;

  factory AyahBookmark.fromJson(Map<String, dynamic> json) => AyahBookmark(
    surahNumber: json['surah'] as int,
    ayahNumber: json['ayah'] as int,
    timestampMs: json['ts'] as int,
    ayahText: json['ayahText'] as String,
  );

  Map<String, dynamic> toJson() => {
    'surah': surahNumber,
    'ayah': ayahNumber,
    'ts': timestampMs,
    'ayahText': ayahText,
  };
}

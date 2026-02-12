import 'package:equatable/equatable.dart';

class JuzModel extends Equatable {
  const JuzModel({
    required this.number,
    required this.startSurah,
    required this.startAyah,
    required this.startSurahName,
  });

  final int number;
  final int startSurah;
  final int startAyah;
  final String startSurahName;

  @override
  List<Object?> get props => [number, startSurah, startAyah, startSurahName];

  static const List<Map<String, dynamic>> starts = [
    {'surah': 1, 'ayah': 1}, // 1
    {'surah': 2, 'ayah': 142}, // 2
    {'surah': 2, 'ayah': 253}, // 3
    {'surah': 3, 'ayah': 93}, // 4 (User requested 93)
    {'surah': 4, 'ayah': 24}, // 5
    {'surah': 4, 'ayah': 148}, // 6
    {'surah': 5, 'ayah': 82}, // 7
    {'surah': 6, 'ayah': 111}, // 8
    {'surah': 7, 'ayah': 88}, // 9
    {'surah': 8, 'ayah': 41}, // 10
    {'surah': 9, 'ayah': 93}, // 11
    {'surah': 11, 'ayah': 6}, // 12
    {'surah': 12, 'ayah': 53}, // 13
    {'surah': 15, 'ayah': 1}, // 14
    {'surah': 17, 'ayah': 1}, // 15
    {'surah': 18, 'ayah': 75}, // 16
    {'surah': 21, 'ayah': 1}, // 17
    {'surah': 23, 'ayah': 1}, // 18
    {'surah': 25, 'ayah': 21}, // 19
    {'surah': 27, 'ayah': 56}, // 20
    {'surah': 29, 'ayah': 46}, // 21
    {'surah': 33, 'ayah': 31}, // 22
    {'surah': 36, 'ayah': 28}, // 23
    {'surah': 39, 'ayah': 32}, // 24
    {'surah': 41, 'ayah': 47}, // 25
    {'surah': 46, 'ayah': 1}, // 26
    {'surah': 51, 'ayah': 31}, // 27
    {'surah': 58, 'ayah': 1}, // 28
    {'surah': 67, 'ayah': 1}, // 29
    {'surah': 78, 'ayah': 1}, // 30
  ];
}

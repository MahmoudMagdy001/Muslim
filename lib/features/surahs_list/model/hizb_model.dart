import 'package:equatable/equatable.dart';

class HizbModel extends Equatable {
  const HizbModel({
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
    {'surah': 2, 'ayah': 75}, // 2
    {'surah': 2, 'ayah': 142}, // 3
    {'surah': 2, 'ayah': 203}, // 4
    {'surah': 2, 'ayah': 253}, // 5
    {'surah': 3, 'ayah': 15}, // 6
    {'surah': 3, 'ayah': 93}, // 7
    {'surah': 3, 'ayah': 171}, // 8
    {'surah': 4, 'ayah': 24}, // 9
    {'surah': 4, 'ayah': 88}, // 10
    {'surah': 4, 'ayah': 148}, // 11
    {'surah': 5, 'ayah': 27}, // 12
    {'surah': 5, 'ayah': 82}, // 13
    {'surah': 6, 'ayah': 36}, // 14
    {'surah': 6, 'ayah': 111}, // 15
    {'surah': 7, 'ayah': 1}, // 16
    {'surah': 7, 'ayah': 88}, // 17
    {'surah': 7, 'ayah': 171}, // 18
    {'surah': 8, 'ayah': 41}, // 19
    {'surah': 9, 'ayah': 34}, // 20
    {'surah': 9, 'ayah': 93}, // 21
    {'surah': 10, 'ayah': 26}, // 22
    {'surah': 11, 'ayah': 6}, // 23
    {'surah': 11, 'ayah': 84}, // 24
    {'surah': 12, 'ayah': 53}, // 25
    {'surah': 13, 'ayah': 19}, // 26
    {'surah': 15, 'ayah': 1}, // 27
    {'surah': 16, 'ayah': 51}, // 28
    {'surah': 17, 'ayah': 1}, // 29
    {'surah': 17, 'ayah': 99}, // 30
    {'surah': 18, 'ayah': 75}, // 31
    {'surah': 20, 'ayah': 1}, // 32
    {'surah': 21, 'ayah': 1}, // 33
    {'surah': 22, 'ayah': 1}, // 34
    {'surah': 23, 'ayah': 1}, // 35
    {'surah': 24, 'ayah': 21}, // 36
    {'surah': 25, 'ayah': 21}, // 37
    {'surah': 26, 'ayah': 111}, // 38
    {'surah': 27, 'ayah': 56}, // 39
    {'surah': 28, 'ayah': 51}, // 40
    {'surah': 29, 'ayah': 46}, // 41
    {'surah': 31, 'ayah': 22}, // 42
    {'surah': 33, 'ayah': 31}, // 43
    {'surah': 34, 'ayah': 24}, // 44
    {'surah': 36, 'ayah': 28}, // 45
    {'surah': 37, 'ayah': 145}, // 46
    {'surah': 39, 'ayah': 32}, // 47
    {'surah': 40, 'ayah': 41}, // 48
    {'surah': 41, 'ayah': 47}, // 49
    {'surah': 43, 'ayah': 24}, // 50
    {'surah': 46, 'ayah': 1}, // 51
    {'surah': 48, 'ayah': 18}, // 52
    {'surah': 51, 'ayah': 31}, // 53
    {'surah': 55, 'ayah': 1}, // 54
    {'surah': 58, 'ayah': 1}, // 55
    {'surah': 62, 'ayah': 1}, // 56
    {'surah': 67, 'ayah': 1}, // 57
    {'surah': 72, 'ayah': 1}, // 58
    {'surah': 78, 'ayah': 1}, // 59
    {'surah': 87, 'ayah': 1}, // 60
  ];
}

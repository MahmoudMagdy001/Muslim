import 'package:equatable/equatable.dart';

enum QuranSurahStatus { initial, loading, loaded, error, alreadyLoaded }

class QuranSurahState extends Equatable {
  const QuranSurahState({
    this.status = QuranSurahStatus.initial,
    this.surahNumber,
    this.ayahCount,
    this.startAyah,
    this.message,
  });

  final QuranSurahStatus status;
  final int? surahNumber;
  final int? ayahCount;
  final int? startAyah;
  final String? message;

  QuranSurahState copyWith({
    QuranSurahStatus? status,
    int? surahNumber,
    int? ayahCount,
    int? startAyah,
    String? message,
  }) => QuranSurahState(
    status: status ?? this.status,
    surahNumber: surahNumber ?? this.surahNumber,
    ayahCount: ayahCount ?? this.ayahCount,
    startAyah: startAyah ?? this.startAyah,
    message: message ?? this.message,
  );

  @override
  List<Object?> get props => [
    status,
    surahNumber,
    ayahCount,
    startAyah,
    message,
  ];
}

enum QuranSurahStatus { initial, loading, loaded, error, alreadyLoaded }

// In your quran_surah_state.dart file
class QuranSurahState {
  const QuranSurahState({
    this.status = QuranSurahStatus.initial,
    this.surahNumber,
    this.ayahCount,
    this.startAyah,
    this.message,
    this.hasIntroBasmala = false,
  });
  final QuranSurahStatus status;
  final int? surahNumber;
  final int? ayahCount;
  final int? startAyah;
  final String? message;
  final bool hasIntroBasmala;

  QuranSurahState copyWith({
    QuranSurahStatus? status,
    int? surahNumber,
    int? ayahCount,
    int? startAyah,
    String? message,
    bool? hasIntroBasmala,
  }) => QuranSurahState(
    status: status ?? this.status,
    surahNumber: surahNumber ?? this.surahNumber,
    ayahCount: ayahCount ?? this.ayahCount,
    startAyah: startAyah ?? this.startAyah,
    message: message ?? this.message,
    hasIntroBasmala: hasIntroBasmala ?? this.hasIntroBasmala,
  );
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:muslim/features/surahs_list/data/models/quran_view_type.dart';

part 'surahs_list_event.freezed.dart';

@freezed
sealed class SurahsListEvent with _$SurahsListEvent {
  const factory SurahsListEvent.loadSurahs({@Default(true) bool isArabic}) = SurahsListLoadSurahs;
  const factory SurahsListEvent.searchInQuran({
    required String keyword,
    required bool partial,
  }) = SurahsListSearchInQuran;
  const factory SurahsListEvent.changeViewType(QuranViewType viewType) = SurahsListChangeViewType;
  const factory SurahsListEvent.saveLastSurah({
    required int surah,
    @Default(1) int lastAyah,
  }) = SurahsListSaveLastSurah;
}

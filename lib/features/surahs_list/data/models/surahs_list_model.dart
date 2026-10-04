import 'package:freezed_annotation/freezed_annotation.dart';

part 'surahs_list_model.freezed.dart';

@freezed
abstract class SurahsListModel with _$SurahsListModel {
  const factory SurahsListModel({
    required int number,
    required String surahName,
    required int ayahCount,
    required String locationArabic,
  }) = _SurahsListModel;
}

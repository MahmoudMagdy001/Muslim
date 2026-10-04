import 'package:freezed_annotation/freezed_annotation.dart';

part 'hadith_entity.freezed.dart';

@freezed
abstract class HadithEntity with _$HadithEntity {
  const factory HadithEntity({
    required String id,
    required String hadithNumber,
    required String hadithArabic,
    required String hadithEnglish,
    required String headingArabic,
    required String headingEnglish,
    required String status,
  }) = _HadithEntity;
}

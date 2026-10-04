import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:muslim/features/hadith/domain/entities/hadith_entity.dart';

part 'hadith_model.freezed.dart';

@Freezed(toJson: false, fromJson: false)
abstract class HadithModel with _$HadithModel {
  const HadithModel._();

  const factory HadithModel({
    required String id,
    required String hadithNumber,
    required String hadithArabic,
    required String hadithEnglish,
    required String headingArabic,
    required String headingEnglish,
    required String status,
  }) = _HadithModel;

  factory HadithModel.fromJson(Map<String, dynamic> json) => HadithModel(
    id: json['id']?.toString() ?? '',
    hadithNumber: json['hadithNumber']?.toString() ?? '',
    hadithArabic: json['hadithArabic']?.toString() ?? '',
    hadithEnglish: json['hadithEnglish']?.toString() ?? '',
    headingArabic: json['headingArabic']?.toString() ?? '',
    headingEnglish: json['headingEnglish']?.toString() ?? '',
    status: json['status']?.toString() ?? '',
  );

  HadithEntity toEntity() => HadithEntity(
    id: id,
    hadithNumber: hadithNumber,
    hadithArabic: hadithArabic,
    hadithEnglish: hadithEnglish,
    headingArabic: headingArabic,
    headingEnglish: headingEnglish,
    status: status,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'hadithNumber': hadithNumber,
    'hadithArabic': hadithArabic,
    'hadithEnglish': hadithEnglish,
    'headingArabic': headingArabic,
    'headingEnglish': headingEnglish,
    'status': status,
  };
}

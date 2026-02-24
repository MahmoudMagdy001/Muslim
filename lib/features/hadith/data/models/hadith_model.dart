import '../../domain/entities/hadith_entity.dart';

class HadithModel extends HadithEntity {
  const HadithModel({
    required super.id,
    required super.hadithNumber,
    required super.hadithArabic,
    required super.headingArabic,
    required super.headingEnglish,
    required super.hadithEnglish,
    required super.status,
  });

  factory HadithModel.fromJson(Map<String, dynamic> json) => HadithModel(
    id: json['id']?.toString() ?? '',
    hadithNumber: json['hadithNumber']?.toString() ?? '',
    hadithArabic: json['hadithArabic']?.toString() ?? '',
    hadithEnglish: json['hadithEnglish']?.toString() ?? '',
    headingArabic: json['headingArabic']?.toString() ?? '',
    headingEnglish: json['headingEnglish']?.toString() ?? '',
    status: json['status']?.toString() ?? '',
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

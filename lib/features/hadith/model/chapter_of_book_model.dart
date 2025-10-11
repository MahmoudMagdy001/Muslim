class ChapterOfBookModel {
  ChapterOfBookModel({
    required this.id,
    required this.chapterNameAr,
    required this.chapterNumber,
    required this.chapterNameEn,
  });

  factory ChapterOfBookModel.fromJson(Map<String, dynamic> json) =>
      ChapterOfBookModel(
        id: json['id'].toString(),
        chapterNameAr: json['chapterArabic']?.toString() ?? '',
        chapterNameEn: json['chapterEnglish']?.toString() ?? '',
        chapterNumber: json['chapterNumber']?.toString() ?? '',
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'chapterArabic': chapterNameAr,
    'chapterEnglish': chapterNameAr,
    'chapterNumber': chapterNumber,
  };

  final String id;
  final String chapterNameAr;
  final String chapterNameEn;
  final String chapterNumber;
}

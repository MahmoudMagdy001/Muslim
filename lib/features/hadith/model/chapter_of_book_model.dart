class ChapterOfBookModel {
  ChapterOfBookModel({
    required this.id,
    required this.chapterName,
    required this.chapterNumber,
  });

  factory ChapterOfBookModel.fromJson(Map<String, dynamic> json) =>
      ChapterOfBookModel(
        id: json['id'].toString(),
        chapterName: json['chapterArabic']?.toString() ?? '',
        chapterNumber: json['chapterNumber']?.toString() ?? '',
      );
  final String id;
  final String chapterName;
  final String chapterNumber;
}

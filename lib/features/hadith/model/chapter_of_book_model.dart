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

  Map<String, dynamic> toJson() => {
    'id': id,
    'chapterArabic': chapterName,
    'chapterNumber': chapterNumber,
  };

  final String id;
  final String chapterName;
  final String chapterNumber;
}

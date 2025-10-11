class HadithBookModel {
  HadithBookModel({
    required this.id,
    required this.bookName,
    required this.writerName,
    required this.hadithCount,
    required this.chapterCount,
    required this.writerDeath,
    required this.bookSlug,
  });

  factory HadithBookModel.fromJson(Map<String, dynamic> json) =>
      HadithBookModel(
        id: json['id'].toString(),
        bookName: json['bookName'] ?? '',
        writerName: json['writerName'] ?? '',
        hadithCount: json['hadiths_count'].toString(),
        chapterCount: json['chapters_count'].toString(),
        writerDeath: json['writerDeath'] ?? '',
        bookSlug: json['bookSlug'] ?? '',
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'bookName': bookName,
    'writerName': writerName,
    'hadiths_count': hadithCount,
    'chapters_count': chapterCount,
    'writerDeath': writerDeath,
    'bookSlug': bookSlug,
  };

  final String id;
  final String bookName;
  final String writerName;
  final String hadithCount;
  final String chapterCount;
  final String writerDeath;
  final String bookSlug;
}

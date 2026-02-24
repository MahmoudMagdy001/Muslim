class HadithBookEntity {
  const HadithBookEntity({
    required this.id,
    required this.bookName,
    required this.writerName,
    required this.hadithCount,
    required this.chapterCount,
    required this.writerDeath,
    required this.bookSlug,
  });

  final String id;
  final String bookName;
  final String writerName;
  final String hadithCount;
  final String chapterCount;
  final String writerDeath;
  final String bookSlug;
}

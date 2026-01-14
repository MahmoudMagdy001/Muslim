import 'package:flutter/material.dart';
import '../model/chapter_of_book_model.dart';
import '../service/chapter_of_book/chapter_service.dart';

class ChapterOfBookController extends ChangeNotifier {
  ChapterOfBookController({required this.bookSlug}) {
    _chaptersFuture = _loadChapters();
    searchController.addListener(_onSearchChanged);
  }
  final ChapterOfBookService _chapterRepository = const ChapterOfBookService();
  final TextEditingController searchController = TextEditingController();

  late Future<List<ChapterOfBookModel>> _chaptersFuture;
  Future<List<ChapterOfBookModel>> get chaptersFuture => _chaptersFuture;

  List<ChapterOfBookModel> _allChapters = [];
  List<ChapterOfBookModel> _filteredChapters = [];
  List<ChapterOfBookModel> get filteredChapters => _filteredChapters;

  final String bookSlug;

  Future<List<ChapterOfBookModel>> _loadChapters() async {
    final chapters = await _chapterRepository.fetchChapters(bookSlug);
    _allChapters = chapters;
    _filteredChapters = chapters;
    return chapters;
  }

  void refreshChapters() {
    _chaptersFuture = _loadChapters();
    notifyListeners();
  }

  void _onSearchChanged() {
    final query = searchController.text.trim().toLowerCase();
    if (query.isEmpty) {
      _filteredChapters = _allChapters;
      notifyListeners();
      return;
    }

    _filteredChapters = _allChapters
        .where((chapter) => _chapterMatchesQuery(chapter, query))
        .toList();
    notifyListeners();
  }

  bool _chapterMatchesQuery(ChapterOfBookModel chapter, String query) {
    final nameAr = chapter.chapterNameAr.toLowerCase();
    final nameEn = chapter.chapterNameEn.toLowerCase();
    final number = chapter.chapterNumber.toLowerCase();

    return nameAr.contains(query) ||
        nameEn.contains(query) ||
        number.contains(query);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}

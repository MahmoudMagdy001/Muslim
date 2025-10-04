import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../../core/utils/navigation_helper.dart';
import 'hadith_screen.dart';
import '../../model/chapter_of_book_model.dart';

class ChapterOfBook extends StatefulWidget {
  const ChapterOfBook({
    required this.bookSlug,
    required this.bookName,
    super.key,
  });
  final String bookSlug;
  final String bookName;

  @override
  State<ChapterOfBook> createState() => _ChapterOfBookState();
}

class _ChapterOfBookState extends State<ChapterOfBook> {
  late Future<List<ChapterOfBookModel>> _chaptersFuture;
  late final ValueNotifier<List<ChapterOfBookModel>> _allChaptersNotifier;
  late final ValueNotifier<List<ChapterOfBookModel>> _filteredChaptersNotifier;
  late final TextEditingController _searchController;
  late final ScrollController _scrollController;

  static const String _apiKey =
      r'$2y$10$VRw6B1T2t5Mt7lIpICLevZU4Cn7iSFAeQLDd0FMtbH33KIf9Ge';

  @override
  void initState() {
    super.initState();
    _allChaptersNotifier = ValueNotifier([]);
    _filteredChaptersNotifier = ValueNotifier([]);
    _searchController = TextEditingController();
    _scrollController = ScrollController();

    _chaptersFuture = _loadChapters();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_onSearchChanged)
      ..dispose();
    _scrollController.dispose();
    _allChaptersNotifier.dispose();
    _filteredChaptersNotifier.dispose();
    super.dispose();
  }

  // ===== تحميل مع كاش =====
  Future<List<ChapterOfBookModel>> _loadChapters() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'chapters_${widget.bookSlug}';
    final cachedData = prefs.getString(key);

    if (cachedData != null) {
      final List decoded = json.decode(cachedData);
      final chapters = decoded
          .map((e) => ChapterOfBookModel.fromJson(e))
          .toList();

      _allChaptersNotifier.value = List.unmodifiable(chapters);
      _filteredChaptersNotifier.value = List.unmodifiable(chapters);

      return chapters;
    } else {
      final chapters = await _fetchChaptersFromApi();
      prefs.setString(
        key,
        json.encode(chapters.map((e) => e.toJson()).toList()),
      );
      return chapters;
    }
  }

  Future<List<ChapterOfBookModel>> _fetchChaptersFromApi() async {
    final url = Uri.parse(
      'https://hadithapi.com/api/${widget.bookSlug}/chapters?apiKey=$_apiKey',
    );
    final response = await http.get(url).timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List chaptersJson = data['chapters'] as List? ?? [];

      final chapters = chaptersJson
          .map((json) => ChapterOfBookModel.fromJson(json))
          .toList();

      _allChaptersNotifier.value = List.unmodifiable(chapters);
      _filteredChaptersNotifier.value = List.unmodifiable(chapters);

      return chapters;
    } else {
      throw Exception('فشل في تحميل الأبواب: ${response.statusCode}');
    }
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim();

    if (query.isEmpty) {
      _filteredChaptersNotifier.value = List.unmodifiable(
        _allChaptersNotifier.value,
      );
    } else {
      final filtered = _allChaptersNotifier.value
          .where(
            (chapter) =>
                chapter.chapterName.contains(query) ||
                chapter.chapterNumber.contains(query),
          )
          .toList();

      _filteredChaptersNotifier.value = List.unmodifiable(filtered);
    }
  }

  @override
  Widget build(BuildContext context) => Directionality(
    textDirection: TextDirection.rtl,
    child: Scaffold(
      appBar: AppBar(title: Text('أبواب ${widget.bookName}')),
      body: FutureBuilder<List<ChapterOfBookModel>>(
        future: _chaptersFuture,
        builder: (context, snapshot) => switch (snapshot.connectionState) {
          ConnectionState.waiting => const _LoadingWidget(),
          ConnectionState.done =>
            snapshot.hasError
                ? _ErrorWidget(error: snapshot.error)
                : _ChaptersContent(
                    allChaptersNotifier: _allChaptersNotifier,
                    filteredChaptersNotifier: _filteredChaptersNotifier,
                    searchController: _searchController,
                    scrollController: _scrollController,
                  ),
          _ => const _EmptyWidget(),
        },
      ),
    ),
  );
}

// ==================== Loading Widget ====================
class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: theme.colorScheme.primary),
          const SizedBox(height: 16),
          Text('جاري تحميل الأبواب...', style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}

// ==================== Error Widget ====================
class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget({required this.error});
  final Object? error;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: theme.colorScheme.error, size: 48),
            const SizedBox(height: 16),
            Text(
              'حدث خطأ أثناء تحميل الأبواب',
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              error?.toString() ?? 'خطأ غير معروف',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.error,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== Empty Widget ====================
class _EmptyWidget extends StatelessWidget {
  const _EmptyWidget();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.menu_book_outlined,
            color: theme.iconTheme.color,
            size: 48,
          ),
          const SizedBox(height: 16),
          Text('لا توجد أبواب', style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}

// ==================== Chapters Content ====================
class _ChaptersContent extends StatelessWidget {
  const _ChaptersContent({
    required this.allChaptersNotifier,
    required this.filteredChaptersNotifier,
    required this.searchController,
    required this.scrollController,
  });
  final ValueNotifier<List<ChapterOfBookModel>> allChaptersNotifier;
  final ValueNotifier<List<ChapterOfBookModel>> filteredChaptersNotifier;
  final TextEditingController searchController;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      _SearchBar(searchController: searchController),
      const SizedBox(height: 8),
      Expanded(
        child: _ChaptersList(
          filteredChaptersNotifier: filteredChaptersNotifier,
          scrollController: scrollController,
        ),
      ),
    ],
  );
}

// ==================== Search Bar ====================
class _SearchBar extends StatelessWidget {
  const _SearchBar({required this.searchController});
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
    child: TextField(
      controller: searchController,
      decoration: const InputDecoration(
        hintText: 'ابحث عن باب...',
        prefixIcon: Icon(Icons.search, color: Colors.grey),
      ),
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
    ),
  );
}

// ==================== Chapters List ====================
class _ChaptersList extends StatelessWidget {
  const _ChaptersList({
    required this.filteredChaptersNotifier,
    required this.scrollController,
  });
  final ValueNotifier<List<ChapterOfBookModel>> filteredChaptersNotifier;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) =>
      ValueListenableBuilder<List<ChapterOfBookModel>>(
        valueListenable: filteredChaptersNotifier,
        builder: (context, chapters, child) {
          if (chapters.isEmpty) {
            return const Center(child: Text('لا توجد نتائج للبحث'));
          }

          return Scrollbar(
            controller: scrollController,

            child: ListView.builder(
              controller: scrollController,
              itemCount: chapters.length,
              padding: const EdgeInsets.only(left: 20, right: 8),
              itemBuilder: (context, index) {
                final chapter = chapters[index];
                return _ChapterCard(chapter: chapter);
              },
            ),
          );
        },
      );
}

// ==================== Chapter Card ====================
class _ChapterCard extends StatelessWidget {
  const _ChapterCard({required this.chapter});
  final ChapterOfBookModel chapter;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _navigateToHadiths(context),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              _ChapterNumberCircle(
                chapterNumber: chapter.chapterNumber,
                theme: theme,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  chapter.chapterName,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: theme.iconTheme.color,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToHadiths(BuildContext context) {
    final state = context.findAncestorStateOfType<_ChapterOfBookState>()!;

    navigateWithTransition(
      type: TransitionType.fade,
      context,
      HadithsScreen(
        bookSlug: state.widget.bookSlug,
        chapterNumber: chapter.chapterNumber,
        chapterName: chapter.chapterName,
      ),
    );
  }
}

// ==================== Chapter Number Circle ====================
class _ChapterNumberCircle extends StatelessWidget {
  const _ChapterNumberCircle({
    required this.chapterNumber,
    required this.theme,
  });
  final String chapterNumber;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: theme.primaryColor.withAlpha((0.1 * 255).toInt()),
      shape: BoxShape.circle,
    ),
    child: Text(
      chapterNumber,
      style: theme.textTheme.titleMedium?.copyWith(
        color: theme.primaryColor,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

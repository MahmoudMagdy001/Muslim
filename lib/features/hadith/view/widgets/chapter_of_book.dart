import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/utils/format_helper.dart';
import '../../../../core/utils/navigation_helper.dart';
import '../../../../l10n/app_localizations.dart';
import '../../service/chapter_of_book/chapter_service.dart';
import 'hadith_view/hadith_view.dart';
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
  final ChapterOfBookService _chapterRepository = const ChapterOfBookService();
  final _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  late Future<List<ChapterOfBookModel>> _chapters;
  List<ChapterOfBookModel> _allChapters = [];
  List<ChapterOfBookModel> _filteredChapters = [];

  @override
  void initState() {
    super.initState();
    _chapters = _loadChapters();
    _searchController.addListener(_onSearchChanged);
  }

  Future<List<ChapterOfBookModel>> _loadChapters() async {
    final chapters = await _chapterRepository.fetchChapters(widget.bookSlug);
    _allChapters = chapters;
    _filteredChapters = chapters;
    return chapters;
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) {
      setState(() => _filteredChapters = _allChapters);
      return;
    }

    final locale = Localizations.localeOf(context).languageCode;
    final isArabicUI = locale == 'ar';

    setState(() {
      _filteredChapters = _allChapters
          .where((chapter) => _chapterMatchesQuery(chapter, query, isArabicUI))
          .toList();
    });
  }

  bool _chapterMatchesQuery(
    ChapterOfBookModel chapter,
    String query,
    bool isArabicUI,
  ) {
    final name = isArabicUI
        ? chapter.chapterNameAr.toLowerCase()
        : chapter.chapterNameEn.toLowerCase();
    final number = chapter.chapterNumber.toLowerCase();

    return name.contains(query) || number.contains(query);
  }

  void _navigateToHadithView(
    ChapterOfBookModel chapter,
    String chapterName,
    String chapterNumber,
  ) {
    navigateWithTransition(
      context,
      HadithView(
        bookSlug: widget.bookSlug,
        chapterNumber: chapter.chapterNumber,
        chapterName: chapterName,
        localizations: AppLocalizations.of(context),
      ),
      type: TransitionType.fade,
    );
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final isArabic = locale == 'ar';
    final theme = Theme.of(context);
    final localization = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('${localization.chapters} ${widget.bookName}'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchField(localization),
            Expanded(child: _buildChapterList(theme, localization, isArabic)),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField(AppLocalizations localization) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
    child: TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: localization.chaptersSearch,
        prefixIcon: const Icon(Icons.search),
      ),
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
    ),
  );

  Widget _buildChapterList(
    ThemeData theme,
    AppLocalizations localization,
    bool isArabic,
  ) => FutureBuilder<List<ChapterOfBookModel>>(
    future: _chapters,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return _buildSkeletonLoader();
      } else if (snapshot.hasError) {
        return _buildErrorWidget(localization, snapshot.error);
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return _buildEmptyWidget(localization);
      } else {
        return _buildChapterListView(theme, isArabic);
      }
    },
  );

  Widget _buildSkeletonLoader() => Skeletonizer(
    child: ListView.builder(
      padding: const EdgeInsetsDirectional.only(
        start: 8,
        end: 16,
        top: 5,
        bottom: 10,
      ),
      itemCount: 10,
      itemBuilder: (context, index) => const _SkeletonChapterItem(),
    ),
  );

  Widget _buildErrorWidget(AppLocalizations localization, Object? error) =>
      Center(child: Text('${localization.errorMain}: $error'));

  Widget _buildEmptyWidget(AppLocalizations localization) =>
      Center(child: Text(localization.chaptersEmpty));

  Widget _buildChapterListView(ThemeData theme, bool isArabic) => Scrollbar(
    controller: _scrollController,
    child: ListView.builder(
      controller: _scrollController,
      itemCount: _filteredChapters.length,
      padding: const EdgeInsetsDirectional.only(
        start: 8,
        end: 16,
        top: 5,
        bottom: 10,
      ),
      itemBuilder: (context, index) {
        final chapter = _filteredChapters[index];
        return _buildChapterItem(chapter, theme, isArabic);
      },
    ),
  );

  Widget _buildChapterItem(
    ChapterOfBookModel chapter,
    ThemeData theme,
    bool isArabic,
  ) {
    final chapterName = isArabic
        ? chapter.chapterNameAr
        : chapter.chapterNameEn;
    final chapterNumber = isArabic
        ? convertToArabicNumbers(chapter.chapterNumber)
        : chapter.chapterNumber;

    return SizedBox(
      height: 100,
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () =>
              _navigateToHadithView(chapter, chapterName, chapterNumber),
          child: Center(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: theme.primaryColor.withAlpha(
                  (0.1 * 255).toInt(),
                ),
                child: Text(
                  chapterNumber,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.primaryColor,
                  ),
                ),
              ),
              title: Text(chapterName, style: theme.textTheme.titleMedium),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

class _SkeletonChapterItem extends StatelessWidget {
  const _SkeletonChapterItem();

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 100,
    child: Card(
      child: Center(
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor.withAlpha(30),
            child: const Text('0'),
          ),
          title: const Text('chapterName'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
      ),
    ),
  );
}

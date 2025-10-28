import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/utils/format_helper.dart';
import '../../../../core/utils/navigation_helper.dart';
import '../../../../l10n/app_localizations.dart';
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
  static const String _apiKey =
      r'$2y$10$VRw6B1T2t5Mt7lIpICLevZU4Cn7iSFAeQLDd0FMtbH33KIf9Ge';

  late Future<List<ChapterOfBookModel>> _chapters;
  final _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<ChapterOfBookModel> _allChapters = [];
  List<ChapterOfBookModel> _filtered = [];

  @override
  void initState() {
    super.initState();
    _chapters = _fetchChapters();
    _searchController.addListener(_filter);
  }

  Future<List<ChapterOfBookModel>> _fetchChapters() async {
    final url = Uri.parse(
      'https://hadithapi.com/api/${widget.bookSlug}/chapters?apiKey=$_apiKey',
    );
    final res = await http.get(url);
    if (res.statusCode != 200) {
      throw Exception('فشل التحميل');
    }
    final Map<String, dynamic> data =
        json.decode(res.body) as Map<String, dynamic>;
    final List<dynamic> chaptersJson = data['chapters'] as List<dynamic>? ?? [];
    final chapters = chaptersJson
        .map((e) => ChapterOfBookModel.fromJson(e as Map<String, dynamic>))
        .toList();

    _allChapters = chapters;
    _filtered = chapters;

    return chapters;
  }

  void _filter() {
    final query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) {
      setState(() => _filtered = _allChapters);
      return;
    }

    // تحديد لغة واجهة التطبيق
    final locale = Localizations.localeOf(context).languageCode;
    final isArabicUI = locale == 'ar';

    setState(() {
      _filtered = _allChapters.where((c) {
        final name = isArabicUI
            ? c.chapterNameAr.toLowerCase()
            : c.chapterNameEn.toLowerCase();
        final num = c.chapterNumber.toLowerCase();

        return name.contains(query) || num.contains(query);
      }).toList();
    });
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: localization.chaptersSearch,
                  prefixIcon: const Icon(Icons.search),
                ),
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<ChapterOfBookModel>>(
                future: _chapters,
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return Skeletonizer(
                      child: ListView.builder(
                        padding: const EdgeInsetsDirectional.only(
                          start: 8,
                          end: 16,
                          top: 5,
                          bottom: 10,
                        ),
                        itemCount: 10,
                        itemBuilder: (context, index) =>
                            const _SkeletonChapterItem(),
                      ),
                    );
                  } else if (snap.hasError) {
                    return Center(
                      child: Text('${localization.errorMain}: ${snap.error}'),
                    );
                  } else if (!snap.hasData || snap.data!.isEmpty) {
                    return Center(child: Text(localization.chaptersEmpty));
                  } else {
                    final chapters = _filtered;
                    return Scrollbar(
                      controller: _scrollController,
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: chapters.length,
                        padding: const EdgeInsetsDirectional.only(
                          start: 8,
                          end: 16,
                          top: 5,
                          bottom: 10,
                        ),
                        itemBuilder: (context, i) {
                          final chapter = chapters[i];
                          final chapterName = !isArabic
                              ? chapter.chapterNameEn
                              : chapter.chapterNameAr;
                          final chapterNumber = !isArabic
                              ? chapter.chapterNumber
                              : convertToArabicNumbers(chapter.chapterNumber);

                          return SizedBox(
                            height: 100,
                            child: Card(
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () => navigateWithTransition(
                                  context,
                                  HadithsScreen(
                                    bookSlug: widget.bookSlug,
                                    chapterNumber: chapter.chapterNumber,
                                    chapterName: chapterName,
                                    localizations: localization,
                                  ),
                                  type: TransitionType.fade,
                                ),
                                child: Center(
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: theme.primaryColor
                                          .withAlpha((0.1 * 255).toInt()),
                                      child: Text(
                                        chapterNumber,
                                        style: theme.textTheme.titleMedium
                                            ?.copyWith(
                                              color: theme.primaryColor,
                                            ),
                                      ),
                                    ),
                                    title: Text(
                                      chapterName,
                                      style: theme.textTheme.titleMedium,
                                    ),
                                    trailing: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          ],
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

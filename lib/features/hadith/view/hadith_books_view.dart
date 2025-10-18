import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:skeletonizer/skeletonizer.dart';

import 'dart:convert';

import '../../../core/ext/extention.dart';
import '../../../core/utils/format_helper.dart';
import '../../../core/utils/navigation_helper.dart';
import 'widgets/chapter_of_book.dart';
import '../model/hadith_book_model.dart';
import '../helper/hadith_helper.dart';

class HadithBooksView extends StatefulWidget {
  const HadithBooksView({super.key});

  @override
  State<HadithBooksView> createState() => _HadithBooksViewState();
}

class _HadithBooksViewState extends State<HadithBooksView> {
  final apiKey = r'$2y$10$VRw6B1T2t5Mt7lIpICLevZU4Cn7iSFAeQLDd0FMtbH33KIf9Ge';
  late Future<List<HadithBookModel>> _booksFuture;
  String _searchText = '';
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _booksFuture = _fetchBooks();
  }

  // جلب الكتب من API مباشرة
  Future<List<HadithBookModel>> _fetchBooks() async {
    final url = Uri.parse('https://hadithapi.com/api/books?apiKey=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          json.decode(response.body) as Map<String, dynamic>;
      final List<dynamic> booksJson = data['books'] as List<dynamic>? ?? [];
      return booksJson
          .map((json) => HadithBookModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('فشل في جلب الكتب');
    }
  }

  // فلترة الكتب حسب البحث
  List<HadithBookModel> _filterBooks(List<HadithBookModel> books) {
    if (_searchText.trim().isEmpty) return books;

    final query = _searchText.trim().toLowerCase();
    final locale = Localizations.localeOf(context).languageCode;
    final isArabicUI = locale == 'ar';

    return books.where((b) {
      // الاسم والكاتب حسب لغة الواجهة
      final name = isArabicUI
          ? (booksArabic[b.bookName] ?? b.bookName)
          : b.bookName;
      final writer = isArabicUI
          ? (writersArabic[b.writerName] ?? b.writerName)
          : b.writerName;

      // تحويلهم لـ lowercase للمقارنة غير الحساسة للحروف
      final nameLower = name.toLowerCase();
      final writerLower = writer.toLowerCase();

      return nameLower.contains(query) || writerLower.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final isArabic = locale == 'ar';

    return Scaffold(
      appBar: AppBar(title: Text(context.localization.hadithBooks)),
      body: SafeArea(
        child: Column(
          children: [
            // ====== Search Bar ======
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              child: TextField(
                decoration: InputDecoration(
                  hintText: context.localization.hadithBooksSearch,
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                ),
                onChanged: (val) => setState(() => _searchText = val),
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
              ),
            ),

            // ====== Books List ======
            Expanded(
              child: FutureBuilder<List<HadithBookModel>>(
                future: _booksFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Skeletonizer(
                      child: ListView.builder(
                        padding: const EdgeInsetsDirectional.only(
                          start: 8,
                          end: 8,
                          bottom: 10,
                        ),
                        itemCount: 8,
                        itemBuilder: (context, index) =>
                            const _SkeletonBookItem(),
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        '${context.localization.hadithBooksError} ${snapshot.error}',
                        style: theme.textTheme.bodyMedium,
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        context.localization.hadithBooksEmpty,
                        style: theme.textTheme.bodyMedium,
                      ),
                    );
                  }

                  final books = _filterBooks(snapshot.data!);

                  return Scrollbar(
                    controller: _scrollController,
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsetsDirectional.only(
                        start: 8,
                        end: 16,
                        top: 5,
                        bottom: 10,
                      ),
                      itemCount: books.length,
                      itemBuilder: (context, index) {
                        final book = books[index];

                        final id = !isArabic
                            ? book.id
                            : convertToArabicNumbers(book.id);
                        final name = !isArabic
                            ? book.bookName
                            : booksArabic[book.bookName]!;
                        final writer = !isArabic
                            ? book.writerName
                            : writersArabic[book.writerName]!;
                        final chpaterCount = !isArabic
                            ? book.chapterCount
                            : convertToArabicNumbers(book.chapterCount);
                        final hadithCount = !isArabic
                            ? book.hadithCount
                            : convertToArabicNumbers(book.hadithCount);

                        if (book.hadithCount == '0') {
                          return const SizedBox.shrink();
                        }

                        return SuccessWidget(
                          book: book,
                          name: name,
                          theme: theme,
                          id: id,
                          writer: writer,
                          chpaterCount: chpaterCount,
                          hadithCount: hadithCount,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkeletonBookItem extends StatelessWidget {
  const _SkeletonBookItem();

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: const Text('0'),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Book Name placeholder',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  'Author: placeholder',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 4),
                Text(
                  'Chapters: 000 ',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 4),

                Text(
                  'Hadiths: 0000',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
    ),
  );
}

class SuccessWidget extends StatelessWidget {
  const SuccessWidget({
    required this.book,
    required this.name,
    required this.theme,
    required this.id,
    required this.writer,
    required this.chpaterCount,
    required this.hadithCount,
    super.key,
  });

  final HadithBookModel book;
  final String name;
  final ThemeData theme;
  final String id;
  final String writer;
  final String chpaterCount;
  final String hadithCount;

  @override
  Widget build(BuildContext context) => Card(
    child: InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        navigateWithTransition(
          type: TransitionType.fade,
          context,
          ChapterOfBook(bookSlug: book.bookSlug, bookName: name),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // رقم الكتاب داخل دائرة
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: theme.primaryColor.withAlpha(30),
                shape: BoxShape.circle,
              ),
              child: Text(
                id,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 16),

            // تفاصيل الكتاب
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${context.localization.writer}: $writer',
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 4),

                  Text(
                    '${context.localization.numberOfChapters} $chpaterCount',
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 4),

                  Text(
                    '${context.localization.numberOfHadiths} $hadithCount',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
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

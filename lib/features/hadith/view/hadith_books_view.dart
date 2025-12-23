import 'package:flutter/material.dart';
import 'package:internet_state_manager/internet_state_manager.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/utils/format_helper.dart';
import '../../../core/utils/navigation_helper.dart';
import '../../../l10n/app_localizations.dart';
import 'widgets/chapter_of_book.dart';
import '../model/hadith_book_model.dart';
import '../helper/hadith_helper.dart';
import 'widgets/saved_hadiths_view/saved_hadith_view.dart';

import '../view_model/hadith_books_controller.dart';

class HadithBooksView extends StatefulWidget {
  const HadithBooksView({super.key});

  @override
  State<HadithBooksView> createState() => _HadithBooksViewState();
}

class _HadithBooksViewState extends State<HadithBooksView> {
  late final HadithBooksController _controller;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller = HadithBooksController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final isArabic = locale == 'ar';
    final localization = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.hadithBooks),
        actions: [
          IconButton(
            onPressed: () {
              navigateWithTransition(
                context,
                const SavedHadithView(),
                type: TransitionType.fade,
              );
            },
            icon: const Icon(Icons.save_alt_outlined),
          ),
        ],
      ),
      body: InternetStateManager(
        noInternetScreen: const NoInternetScreen(),
        onRestoreInternetConnection: _controller.refreshBooks,
        child: SafeArea(
          child: ListenableBuilder(
            listenable: _controller,
            builder: (context, _) => Column(
              children: [
                // ====== Search Bar ======
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: localization.hadithBooksSearch,
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    ),
                    onChanged: _controller.updateSearchText,
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  ),
                ),

                // ====== Books List ======
                Expanded(
                  child: FutureBuilder<List<HadithBookModel>>(
                    future: _controller.booksFuture,
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
                            '${localization.hadithBooksError} ${snapshot.error}',
                            style: theme.textTheme.bodyMedium,
                          ),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(
                          child: Text(
                            localization.hadithBooksEmpty,
                            style: theme.textTheme.bodyMedium,
                          ),
                        );
                      }

                      final books = _controller.filterBooks(
                        snapshot.data!,
                        locale,
                      );

                      return RefreshIndicator(
                        onRefresh: () async {
                          _controller.refreshBooks();
                          await _controller.booksFuture;
                        },
                        child: Scrollbar(
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
                                localization: localization,
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
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
    required this.localization,
    super.key,
  });

  final HadithBookModel book;
  final String name;
  final ThemeData theme;
  final String id;
  final String writer;
  final String chpaterCount;
  final String hadithCount;
  final AppLocalizations localization;

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
                    '${localization.writer}: $writer',
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 4),

                  Text(
                    '${localization.numberOfChapters} $chpaterCount',
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 4),

                  Text(
                    '${localization.numberOfHadiths} $hadithCount',
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

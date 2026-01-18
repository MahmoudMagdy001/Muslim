import 'package:flutter/material.dart';
import 'package:internet_state_manager/internet_state_manager.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/custom_loading_indicator.dart';
import '../../../core/utils/format_helper.dart';
import '../../../core/utils/navigation_helper.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../../l10n/app_localizations.dart';
import 'widgets/chapter_of_book.dart';
import '../model/hadith_book_model.dart';
import '../helper/hadith_helper.dart';
import '../../../../core/utils/extensions.dart';
import 'widgets/saved_hadiths_view/saved_hadith_view.dart';

import '../view_model/hadith_books_controller.dart';
import 'widgets/hadith_of_the_day_card.dart';

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
    final theme = context.theme;
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
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.toW,
                    vertical: 8.toH,
                  ),
                  child: TextField(
                    textAlign: isArabic ? TextAlign.right : TextAlign.left,
                    decoration: InputDecoration(
                      hintText: localization.hadithBooksSearch,
                      hintStyle: context.textTheme.bodyLarge?.copyWith(
                        color: context.colorScheme.onSurfaceVariant.withAlpha(
                          150,
                        ),
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 8.toH,
                          horizontal: 8.toW,
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 8.toH,
                            horizontal: 8.toW,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            borderRadius: BorderRadius.circular(12.toR),
                          ),
                          child: Image.asset(
                            'assets/quran/search.png',
                            width: 20.toW,
                            color: context.colorScheme.secondary,
                          ),
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20.toW,
                        vertical: 12.toH,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.toR),
                        borderSide: BorderSide(
                          color: theme.primaryColor,
                          width: 1.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.toR),
                        borderSide: BorderSide(
                          color: theme.primaryColor,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.toR),
                        borderSide: BorderSide(
                          color: theme.primaryColor,
                          width: 2,
                        ),
                      ),
                      filled: true,
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
                        return CustomLoadingIndicator(
                          text: localization.loading,
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
                              start: 6,
                              end: 20,
                              top: 5,
                              bottom: 10,
                            ),
                            itemCount: books.length + 2,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return ListenableBuilder(
                                  listenable: _controller,
                                  builder: (context, _) => HadithOfTheDayCard(
                                    randomHadithFuture:
                                        _controller.randomHadithFuture,
                                  ),
                                );
                              }

                              if (index == 1) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    right: 16,
                                    top: 16,
                                  ),
                                  child: Text(
                                    localization.hadithSources,
                                    style: theme.textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.onSurface,
                                    ),
                                  ),
                                );
                              }

                              final book = books[index - 2];

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
  Widget build(BuildContext context) => Container(
    margin: EdgeInsets.symmetric(vertical: 6.toH),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: AppColors.cardGradient(context),
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(15.toR),
    ),
    child: InkWell(
      borderRadius: BorderRadius.circular(15.toR),
      onTap: () {
        navigateWithTransition(
          type: TransitionType.fade,
          context,
          ChapterOfBook(bookSlug: book.bookSlug, bookName: name),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.toW, vertical: 12.toH),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/quran/marker.png',
                  width: 40.toW,
                  height: 40.toH,
                ),
                Text(
                  id,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(width: 16.toW),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.toH),
                  Text(
                    '${localization.writer}: $writer',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFFC0C0C0),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.toH),
                  Text(
                    '${localization.numberOfChapters} $chpaterCount - ${localization.numberOfHadiths} $hadithCount',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: const Color(0xFFC0C0C0),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16.toR),
          ],
        ),
      ),
    ),
  );
}

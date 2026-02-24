import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_state_manager/internet_state_manager.dart';

import '../../../../../core/di/service_locator.dart';
import '../../../../../core/utils/extensions.dart';
import '../../../../../core/utils/format_helper.dart';
import '../../../../../core/utils/navigation_helper.dart';
import '../../../../../core/utils/responsive_helper.dart';
import '../../../../../core/widgets/custom_loading_indicator.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../domain/entities/chapter_of_book_entity.dart';
import '../../cubit/chapter_of_book_cubit.dart';
import '../../cubit/chapter_of_book_state.dart';
import '../../cubit/hadith_cubit.dart';
import 'hadith_view/hadith_view.dart';

class ChapterOfBook extends StatelessWidget {
  const ChapterOfBook({
    required this.bookSlug,
    required this.bookName,
    super.key,
  });

  final String bookSlug;
  final String bookName;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => getIt<ChapterOfBookCubit>()..loadChapters(bookSlug),
    child: _ChapterOfBookContent(bookSlug: bookSlug, bookName: bookName),
  );
}

class _ChapterOfBookContent extends StatefulWidget {
  const _ChapterOfBookContent({required this.bookSlug, required this.bookName});

  final String bookSlug;
  final String bookName;

  @override
  State<_ChapterOfBookContent> createState() => _ChapterOfBookContentState();
}

class _ChapterOfBookContentState extends State<_ChapterOfBookContent> {
  final ScrollController _scrollController = ScrollController();

  List<ChapterOfBookEntity> _filterChapters(
    List<ChapterOfBookEntity> chapters,
    String query,
  ) {
    if (query.isEmpty) return chapters;

    final lowerQuery = query.trim().toLowerCase();

    return chapters.where((chapter) {
      final nameAr = chapter.chapterNameAr.toLowerCase();
      final nameEn = chapter.chapterNameEn.toLowerCase();
      final number = chapter.chapterNumber.toLowerCase();

      return nameAr.contains(lowerQuery) ||
          nameEn.contains(lowerQuery) ||
          number.contains(lowerQuery);
    }).toList();
  }

  void _navigateToHadithView(
    BuildContext context,
    ChapterOfBookEntity chapter,
    String chapterName,
    String chapterNumber,
  ) {
    navigateWithTransition(
      context,
      BlocProvider(
        create: (context) => getIt<HadithCubit>()
          ..initializeData(widget.bookSlug, chapter.chapterNumber, chapterName),
        child: HadithView(
          bookSlug: widget.bookSlug,
          chapterNumber: chapter.chapterNumber,
          chapterName: chapterName,
          localizations: AppLocalizations.of(context),
        ),
      ),
      type: TransitionType.fade,
    );
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final isArabic = locale == 'ar';
    final theme = context.theme;
    final localization = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('${localization.chapters} ${widget.bookName}'),
      ),
      body: InternetStateManager(
        noInternetScreen: const NoInternetScreen(),
        onRestoreInternetConnection: () {
          context.read<ChapterOfBookCubit>().loadChapters(widget.bookSlug);
        },
        child: SafeArea(
          child: Column(
            children: [
              _buildSearchField(localization, isArabic, theme, context),
              Expanded(
                child: BlocBuilder<ChapterOfBookCubit, ChapterOfBookState>(
                  builder: (context, state) {
                    if (state.status == ChapterOfBookStatus.loading ||
                        state.status == ChapterOfBookStatus.initial) {
                      return CustomLoadingIndicator(
                        text: 'جاري تحميل ابواب ${widget.bookName}',
                      );
                    } else if (state.status == ChapterOfBookStatus.failure) {
                      return _buildErrorWidget(
                        localization,
                        state.errorMessage,
                      );
                    } else if (state.chapters.isEmpty) {
                      return _buildEmptyWidget(localization);
                    }

                    final chapters = _filterChapters(
                      state.chapters,
                      state.searchText,
                    );

                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<ChapterOfBookCubit>().loadChapters(
                          widget.bookSlug,
                        );
                        await Future.delayed(const Duration(milliseconds: 500));
                      },
                      child: _buildChapterListView(chapters, theme, isArabic),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField(
    AppLocalizations localization,
    bool isArabic,
    ThemeData theme,
    BuildContext context,
  ) => Padding(
    padding: EdgeInsets.symmetric(horizontal: 12.toW, vertical: 8.toH),
    child: TextField(
      onChanged: (text) =>
          context.read<ChapterOfBookCubit>().updateSearchText(text),
      textAlign: isArabic ? TextAlign.right : TextAlign.left,
      decoration: InputDecoration(
        hintText: localization.chaptersSearch,
        hintStyle: context.textTheme.bodyLarge?.copyWith(
          color: context.colorScheme.onSurfaceVariant.withAlpha(150),
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.toH, horizontal: 8.toW),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.toH, horizontal: 8.toW),
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
          horizontal: 12.toW,
          vertical: 12.toH,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.toR),
          borderSide: BorderSide(color: theme.primaryColor, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.toR),
          borderSide: BorderSide(color: theme.primaryColor, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.toR),
          borderSide: BorderSide(color: theme.primaryColor, width: 2),
        ),
        filled: true,
      ),
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
    ),
  );

  Widget _buildErrorWidget(AppLocalizations localization, Object? error) =>
      Center(child: Text('${localization.errorMain}: $error'));

  Widget _buildEmptyWidget(AppLocalizations localization) =>
      Center(child: Text(localization.chaptersEmpty));

  Widget _buildChapterListView(
    List<ChapterOfBookEntity> chapters,
    ThemeData theme,
    bool isArabic,
  ) => Scrollbar(
    controller: _scrollController,
    child: ListView.builder(
      controller: _scrollController,
      itemCount: chapters.length,
      padding: const EdgeInsetsDirectional.only(start: 6, end: 20, bottom: 10),
      itemBuilder: (context, index) {
        final chapter = chapters[index];
        return _buildChapterItem(context, chapter, theme, isArabic);
      },
    ),
  );

  Widget _buildChapterItem(
    BuildContext context,
    ChapterOfBookEntity chapter,
    ThemeData theme,
    bool isArabic,
  ) {
    final chapterName = isArabic
        ? chapter.chapterNameAr
        : chapter.chapterNameEn;
    final chapterNumber = isArabic
        ? convertToArabicNumbers(chapter.chapterNumber)
        : chapter.chapterNumber;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.toH),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: context.cardGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15.toR),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15.toR),
        onTap: () =>
            _navigateToHadithView(context, chapter, chapterName, chapterNumber),
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
                    chapterNumber,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 16.toW),
              Expanded(
                child: Text(
                  chapterName,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16.toR),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_state_manager/internet_state_manager.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/custom_loading_indicator.dart';
import '../../../../core/utils/format_helper.dart';
import '../../../../core/utils/navigation_helper.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../l10n/app_localizations.dart';

import '../../model/chapter_of_book_model.dart';
import '../../view_model/hadith/hadith_cubit.dart';
import 'hadith_view/hadith_view.dart';

import '../../view_model/chapter_of_book_controller.dart';

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
  late final ChapterOfBookController _controller;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller = ChapterOfBookController(bookSlug: widget.bookSlug);
  }

  void _navigateToHadithView(
    ChapterOfBookModel chapter,
    String chapterName,
    String chapterNumber,
  ) {
    navigateWithTransition(
      context,
      BlocProvider(
        create: (context) => HadithCubit(
          bookSlug: widget.bookSlug,
          chapterNumber: chapter.chapterNumber,
          chapterName: chapterName,
        )..initializeData(),
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
        onRestoreInternetConnection: _controller.refreshChapters,
        child: SafeArea(
          child: ListenableBuilder(
            listenable: _controller,
            builder: (context, _) => Column(
              children: [
                _buildSearchField(localization, isArabic, theme),
                Expanded(
                  child: _buildChapterList(theme, localization, isArabic),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField(
    AppLocalizations localization,
    bool isArabic,
    ThemeData theme,
  ) => Padding(
    padding: EdgeInsets.symmetric(horizontal: 12.toW, vertical: 8.toH),
    child: TextField(
      controller: _controller.searchController,
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

  Widget _buildChapterList(
    ThemeData theme,
    AppLocalizations localization,
    bool isArabic,
  ) => FutureBuilder<List<ChapterOfBookModel>>(
    future: _controller.chaptersFuture,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CustomLoadingIndicator(
          text: 'جاري تحميل ابواب ${widget.bookName}',
        );
      } else if (snapshot.hasError) {
        return _buildErrorWidget(localization, snapshot.error);
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return _buildEmptyWidget(localization);
      } else {
        return RefreshIndicator(
          onRefresh: () async {
            _controller.refreshChapters();
            await _controller.chaptersFuture;
          },
          child: _buildChapterListView(theme, isArabic),
        );
      }
    },
  );

  Widget _buildErrorWidget(AppLocalizations localization, Object? error) =>
      Center(child: Text('${localization.errorMain}: $error'));

  Widget _buildEmptyWidget(AppLocalizations localization) =>
      Center(child: Text(localization.chaptersEmpty));

  Widget _buildChapterListView(ThemeData theme, bool isArabic) => Scrollbar(
    controller: _scrollController,
    child: ListView.builder(
      controller: _scrollController,
      itemCount: _controller.filteredChapters.length,
      padding: const EdgeInsetsDirectional.only(start: 6, end: 20, bottom: 10),
      itemBuilder: (context, index) {
        final chapter = _controller.filteredChapters[index];
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

    return Container(
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
        onTap: () => _navigateToHadithView(chapter, chapterName, chapterNumber),
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
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

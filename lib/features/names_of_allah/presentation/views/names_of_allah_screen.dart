import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim/core/di/service_locator.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/overmark_helper.dart';
import 'package:muslim/core/utils/responsive_helper.dart';
import 'package:muslim/core/widgets/custom_loading_indicator.dart';
import 'package:muslim/features/names_of_allah/domain/entities/name_of_allah_entity.dart';
import 'package:muslim/features/names_of_allah/presentation/cubit/names_of_allah_cubit.dart';
import 'package:muslim/features/names_of_allah/presentation/cubit/names_of_allah_state.dart';
import 'package:muslim/features/names_of_allah/presentation/views/widgets/name_of_allah_card.dart';
import 'package:muslim/features/names_of_allah/presentation/views/widgets/shareable_name_of_allah_card.dart';
import 'package:muslim/l10n/app_localizations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class NamesOfAllahScreen extends StatelessWidget {
  const NamesOfAllahScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<NamesOfAllahCubit>(),
    child: const _NamesOfAllahContent(),
  );
}

class _NamesOfAllahContent extends StatefulWidget {
  const _NamesOfAllahContent();

  @override
  State<_NamesOfAllahContent> createState() => _NamesOfAllahContentState();
}

class _NamesOfAllahContentState extends State<_NamesOfAllahContent> {
  final TextEditingController _searchController = TextEditingController();
  final ScreenshotController _screenshotController = ScreenshotController();
  final ValueNotifier<String> searchQueryNotifier = ValueNotifier('');
  final ValueNotifier<bool> isSharingNotifier = ValueNotifier(false);
  final ValueNotifier<int?> sharingIndexNotifier = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    unawaited(context.read<NamesOfAllahCubit>().getNamesOfAllah());
    _searchController.addListener(() {
      searchQueryNotifier.value = _searchController.text.trim();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        unawaited(AppTourHelper.showNamesOfAllahTour(context));
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    searchQueryNotifier.dispose();
    isSharingNotifier.dispose();
    sharingIndexNotifier.dispose();
    super.dispose();
  }

  Future<void> _shareAsImage(
    NameOfAllahEntity data,
    int index,
  ) async {
    isSharingNotifier.value = true;
    sharingIndexNotifier.value = index;

    final l10n = context.l10n;

    try {
      // Small delay to ensure UI updates before capture
      await Future<void>.delayed(const Duration(milliseconds: 50));
      final imageBytes = await _screenshotController.captureFromWidget(
        ShareableNameOfAllahCard(data: data),
        delay: const Duration(milliseconds: 10),
      );

      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/names_of_allah_${index + 1}.png');
      await file.writeAsBytes(imageBytes);

      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path)],
          text: l10n.namesOfAllahShareText,
          subject: l10n.namesOfAllah,
        ),
      );
    } on Object catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              l10n.shareError,
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      isSharingNotifier.value = false;
      sharingIndexNotifier.value = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.namesOfAllah),
        actions: [
          IconButton(
            onPressed: () => unawaited(
              AppTourHelper.showNamesOfAllahTour(context, force: true),
            ),
            icon: const Icon(Icons.explore_outlined),
            tooltip: localizations.tourNamesOfAllahTitle,
          ),
        ],
      ),
      body: BlocBuilder<NamesOfAllahCubit, NamesOfAllahState>(
        builder: (context, state) {
          if (state is NamesOfAllahLoaded) {
            final allData = state.names;

            return Column(
              children: [
                Padding(
                  key: AppTourKeys.namesSearchKey,
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.toW,
                    vertical: 8.toH,
                  ),
                  child: TextField(
                    controller: _searchController,
                    textAlign: isArabic ? TextAlign.right : TextAlign.left,
                    decoration: InputDecoration(
                      hintText: isArabic
                          ? 'ابحث عن اسم الله...'
                          : 'Search for Allah\'s name...',
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
                            color: context.colorScheme.primary,
                            borderRadius: BorderRadius.circular(12.toR),
                          ),
                          child: Image.asset(
                            'assets/quran/search.png',
                            width: 20.toW,
                            // ponytail: cache dimensions to save memory at runtime
                            cacheWidth: 60,
                            color: context.colorScheme.secondary,
                          ),
                        ),
                      ),
                      suffixIcon: ValueListenableBuilder<TextEditingValue>(
                        valueListenable: _searchController,
                        builder: (context, value, _) => value.text.isNotEmpty
                            ? IconButton(
                                icon: Icon(
                                  Icons.clear,
                                  color: context.theme.primaryColor,
                                ),
                                onPressed: () {
                                  _searchController.clear();
                                  searchQueryNotifier.value = '';
                                },
                              )
                            : const SizedBox.shrink(),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20.toW,
                        vertical: 12.toH,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.toR),
                        borderSide: BorderSide(
                          color: context.theme.primaryColor,
                          width: 1.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.toR),
                        borderSide: BorderSide(
                          color: context.theme.primaryColor,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.toR),
                        borderSide: BorderSide(
                          color: context.theme.primaryColor,
                          width: 2,
                        ),
                      ),
                      filled: true,
                    ),
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  ),
                ),
                Expanded(
                  child: ValueListenableBuilder<String>(
                    valueListenable: searchQueryNotifier,
                    builder: (context, searchQuery, child) {
                      // Filter data based on search query
                      final filteredData = allData.where((data) {
                        if (searchQuery.isEmpty) return true;
                        final searchLower = searchQuery.toLowerCase();
                        final name = isArabic
                            ? data.name
                            : data.nameTranslation;
                        final text = isArabic
                            ? data.text
                            : data.textTranslation;
                        return name.toLowerCase().contains(searchLower) ||
                            text.toLowerCase().contains(searchLower);
                      }).toList();

                      if (filteredData.isEmpty) {
                        return Center(
                          child: Text(
                            localizations.noResultsFound,
                            style: context.textTheme.bodyLarge,
                          ),
                        );
                      }

                      return ValueListenableBuilder<bool>(
                        valueListenable: isSharingNotifier,
                        builder: (context, isSharing, _) =>
                            ValueListenableBuilder<int?>(
                              valueListenable: sharingIndexNotifier,
                              builder: (context, sharingIndex, _) =>
                                  ListView.builder(
                                    itemCount: filteredData.length,
                                    itemBuilder: (context, index) {
                                      final data = filteredData[index];
                                      final originalIndex = allData.indexOf(
                                        data,
                                      );

                                      return NameOfAllahCard(
                                        data: data,
                                        index: originalIndex,
                                        isSharing:
                                            isSharing &&
                                            sharingIndex == originalIndex,
                                        onShare: () => _shareAsImage(
                                          data,
                                          originalIndex,
                                        ),
                                      );
                                    },
                                  ),
                            ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is NamesOfAllahError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: CustomLoadingIndicator(text: ''));
        },
      ),
    );
  }
}

// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:http/http.dart' as http;

import '../../../../core/ext/extention.dart';
import '../../model/hadith_model.dart';

class HadithsScreen extends StatefulWidget {
  const HadithsScreen({
    required this.bookSlug,
    required this.chapterNumber,
    required this.chapterName,
    super.key,
  });

  final String bookSlug;
  final String chapterNumber;
  final String chapterName;

  @override
  State<HadithsScreen> createState() => _HadithsScreenState();
}

class _HadithsScreenState extends State<HadithsScreen> {
  static const String _apiKey =
      r'$2y$10$VRw6B1T2t5Mt7lIpICLevZU4Cn7iSFAeQLDd0FMtbH33KIf9Ge';

  final List<HadithModel> _hadiths = [];
  final ScrollController _scrollController = ScrollController();

  bool _isLoading = false;
  bool _hasMore = true;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _fetchHadiths();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (!_isLoading && _hasMore) {
        _fetchHadiths(loadMore: true);
      }
    }
  }

  Future<void> _fetchHadiths({bool loadMore = false}) async {
    if (_isLoading) return;

    if (!mounted) return;
    setState(() => _isLoading = true);

    try {
      final page = loadMore ? _currentPage + 1 : 1;
      final url = Uri.parse(
        'https://hadithapi.com/api/hadiths/?apiKey=$_apiKey&book=${widget.bookSlug}&chapter=${widget.chapterNumber}&page=$page',
      );

      final response = await http.get(url);
      if (!mounted) return;

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List hadithsJson = data['hadiths']['data'] ?? [];

        final List<HadithModel> newHadiths = hadithsJson
            .map((e) => HadithModel.fromJson(e as Map<String, dynamic>))
            .toList();

        if (!mounted) return;
        setState(() {
          if (loadMore) {
            _hadiths.addAll(newHadiths);
            _currentPage = page;
          } else {
            _hadiths
              ..clear()
              ..addAll(newHadiths);
            _currentPage = 1;
          }
          _hasMore = data['hadiths']['next_page_url'] != null;
        });
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.localization.hadithError)),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${context.localization.errorMain} $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_scrollListener)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final isArabic = locale == 'ar';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${context.localization.hadithstitle} ${widget.chapterName}',
        ),
      ),
      body: _hadiths.isEmpty && _isLoading
          ? Skeletonizer(
              child: ListView.builder(
                padding: const EdgeInsetsDirectional.only(
                  start: 8,
                  end: 16,
                  top: 10,
                  bottom: 10,
                ),
                itemCount: 5,
                itemBuilder: (context, index) => const _SkeletonHadithItem(),
              ),
            )
          : SafeArea(
              child: Scrollbar(
                controller: _scrollController,
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsetsDirectional.only(
                    start: 8,
                    end: 16,
                    top: 10,
                    bottom: 10,
                  ),
                  itemCount: _hadiths.length + (_hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < _hadiths.length) {
                      final hadith = _hadiths[index];

                      final hadithText = isArabic
                          ? hadith.hadithArabic
                          : hadith.hadithEnglish;

                      final heading = isArabic
                          ? hadith.headingArabic
                          : hadith.headingEnglish;

                      final status = isArabic
                          ? _statusMap[hadith.status]!
                          : hadith.status;

                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (heading.isNotEmpty) ...[
                                Text(
                                  heading,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    color: theme.primaryColor,
                                  ),
                                ),
                                const SizedBox(height: 16),
                              ],
                              SelectableText(
                                hadithText,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  height: isArabic ? 2 : 1.4,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${context.localization.hadithStatus}: $status',
                                textAlign: TextAlign.end,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: theme.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                  },
                ),
              ),
            ),
    );
  }

  static const Map<String, String> _statusMap = {
    'Sahih': 'صحيح',
    'sahih': 'صحيح',
    'Hasan': 'حسن',
    'hasan': 'حسن',
    'Da`eef': 'ضعيف',
    'da`eef': 'ضعيف',
  };
}

class _SkeletonHadithItem extends StatelessWidget {
  const _SkeletonHadithItem();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('hadith.headingArabic', style: theme.textTheme.titleMedium),
            const SizedBox(height: 16),
            const Text('hadith.hadithArabic\nhadith.hadithArabic'),
            const SizedBox(height: 8),
            const Text('الحكم: صحيح'),
          ],
        ),
      ),
    );
  }
}

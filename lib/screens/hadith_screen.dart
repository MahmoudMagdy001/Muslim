// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Hadith {
  Hadith({
    required this.id,
    required this.hadithNumber,
    required this.hadithArabic,
    required this.headingArabic,
    required this.status,
  });

  factory Hadith.fromJson(Map<String, dynamic> json) => Hadith(
    id: json['id']?.toString() ?? '',
    hadithNumber: json['hadithNumber']?.toString() ?? '',
    hadithArabic: json['hadithArabic']?.toString() ?? '',
    headingArabic: json['headingArabic']?.toString() ?? '',
    status: json['status']?.toString() ?? '',
  );
  final String id;
  final String hadithNumber;
  final String hadithArabic;
  final String headingArabic;
  final String status;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Hadith && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

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

  late final ValueNotifier<List<Hadith>> _hadithsNotifier;
  late final ValueNotifier<int> _currentPageNotifier;
  late final ValueNotifier<bool> _isLoadingNotifier;
  late final ValueNotifier<bool> _hasMoreNotifier;
  late final ScrollController _scrollController;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _hadithsNotifier = ValueNotifier([]);
    _currentPageNotifier = ValueNotifier(1);
    _isLoadingNotifier = ValueNotifier(false);
    _hasMoreNotifier = ValueNotifier(true);
    _scrollController = ScrollController();
    _searchController = TextEditingController();

    _fetchHadiths();

    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (!_isLoadingNotifier.value && _hasMoreNotifier.value) {
        _fetchHadiths(loadMore: true);
      }
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_scrollListener)
      ..dispose();
    _searchController.dispose();
    _hadithsNotifier.dispose();
    _currentPageNotifier.dispose();
    _isLoadingNotifier.dispose();
    _hasMoreNotifier.dispose();
    super.dispose();
  }

  Future<void> _fetchHadiths({bool loadMore = false}) async {
    if (_isLoadingNotifier.value || !_hasMoreNotifier.value) return;

    _isLoadingNotifier.value = true;

    try {
      final page = loadMore ? _currentPageNotifier.value + 1 : 1;
      final url = Uri.parse(
        'https://hadithapi.com/api/hadiths/?apiKey=$_apiKey&book=${widget.bookSlug}&chapter=${widget.chapterNumber}&page=$page',
      );

      final response = await http.get(url).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List hadithsJson = data['hadiths']['data'] as List? ?? [];

        final List<Hadith> fetchedHadiths = hadithsJson
            .map((json) => Hadith.fromJson(json as Map<String, dynamic>))
            .toList();

        if (loadMore) {
          final currentHadiths = _hadithsNotifier.value;
          final updatedHadiths = List<Hadith>.from(currentHadiths)
            ..addAll(fetchedHadiths);
          _hadithsNotifier.value = List.unmodifiable(updatedHadiths);
          _currentPageNotifier.value = page;
        } else {
          _hadithsNotifier.value = List.unmodifiable(fetchedHadiths);
          _currentPageNotifier.value = 1;
        }

        _hasMoreNotifier.value = data['hadiths']['next_page_url'] != null;
      } else {
        throw Exception('فشل في تحميل الأحاديث: ${response.statusCode}');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('خطأ في تحميل الأحاديث: $e')));
      }
    } finally {
      _isLoadingNotifier.value = false;
    }
  }

  @override
  Widget build(BuildContext context) => Directionality(
    textDirection: TextDirection.rtl,
    child: Scaffold(
      appBar: AppBar(title: Text('أحاديث ${widget.chapterName}')),
      body: _HadithsContent(
        hadithsNotifier: _hadithsNotifier,
        isLoadingNotifier: _isLoadingNotifier,
        hasMoreNotifier: _hasMoreNotifier,
        scrollController: _scrollController,
      ),
    ),
  );
}

// ==================== Hadiths Content ====================

class _HadithsContent extends StatelessWidget {
  const _HadithsContent({
    required this.hadithsNotifier,
    required this.isLoadingNotifier,
    required this.hasMoreNotifier,
    required this.scrollController,
  });

  final ValueNotifier<List<Hadith>> hadithsNotifier;
  final ValueNotifier<bool> isLoadingNotifier;
  final ValueNotifier<bool> hasMoreNotifier;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<List<Hadith>>(
      valueListenable: hadithsNotifier,
      builder: (context, hadiths, child) => ValueListenableBuilder<bool>(
          valueListenable: isLoadingNotifier,
          builder: (context, isLoading, child) => ValueListenableBuilder<bool>(
              valueListenable: hasMoreNotifier,
              builder: (context, hasMore, child) {
                if (hadiths.isEmpty && isLoading) {
                  // 🚀 مفيش Scrollbar هنا
                  return const _LoadingWidget();
                }

                // 🚀 Scrollbar يظهر بس لما فيه بيانات
                return Scrollbar(
                  controller: scrollController,
                  thickness: 8.0,
                  radius: const Radius.circular(16),
                  trackVisibility: true,
                  interactive: true,
                  child: _HadithsList(
                    hadiths: hadiths,
                    isLoading: isLoading,
                    hasMore: hasMore,
                    scrollController: scrollController,
                  ),
                );
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
          Text('جاري تحميل الأحاديث...', style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}

// ==================== Hadiths List ====================
class _HadithsList extends StatelessWidget {
  const _HadithsList({
    required this.hadiths,
    required this.isLoading,
    required this.hasMore,
    required this.scrollController,
  });
  final List<Hadith> hadiths;
  final bool isLoading;
  final bool hasMore;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) => ListView.builder(
    controller: scrollController,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    itemCount: hadiths.length + (hasMore ? 1 : 0),
    itemBuilder: (context, index) {
      if (index < hadiths.length) {
        return _HadithCard(hadith: hadiths[index]);
      } else {
        return const _LoadingMoreWidget();
      }
    },
  );
}

// ==================== Loading More Widget ====================
class _LoadingMoreWidget extends StatelessWidget {
  const _LoadingMoreWidget();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: CircularProgressIndicator(color: theme.colorScheme.primary),
      ),
    );
  }
}

// ==================== Hadith Card ====================
class _HadithCard extends StatelessWidget {
  const _HadithCard({required this.hadith});
  final Hadith hadith;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final statusArabic = _HadithCard._statusMap[hadith.status] ?? hadith.status;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 👇 عنوان الباب لو موجود
            if (hadith.headingArabic.isNotEmpty) ...[
              Text(
                hadith.headingArabic,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.primaryColor,
                ),
              ),
              const SizedBox(height: 16),
            ],

            SelectableText(
              hadith.hadithArabic,

              style: theme.textTheme.titleMedium?.copyWith(height: 2  ),
            ),
            const SizedBox(height: 8),
            Text(
              'الحكم: $statusArabic',
              textAlign: TextAlign.end,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.primaryColor,

              ),
            ),
          ],
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

// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

  // مفتاح التخزين في Shared Preferences
  String get _cacheKey => 'hadiths_${widget.bookSlug}_${widget.chapterNumber}';

  late final ValueNotifier<List<HadithModel>> _hadithsNotifier;
  late final ValueNotifier<int> _currentPageNotifier;
  late final ValueNotifier<bool> _isLoadingNotifier;
  late final ValueNotifier<bool> _hasMoreNotifier;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _hadithsNotifier = ValueNotifier([]);
    _currentPageNotifier = ValueNotifier(1);
    _isLoadingNotifier = ValueNotifier(false);
    _hasMoreNotifier = ValueNotifier(true);
    _scrollController = ScrollController();

    _loadCachedData().then((_) => _fetchHadiths());

    _scrollController.addListener(_scrollListener);
  }

  // تحميل البيانات المخزنة مسبقاً
  // تحميل البيانات المخزنة مسبقاً
  Future<void> _loadCachedData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedData = prefs.getString(_cacheKey);

      if (cachedData != null) {
        final dynamic decodedData = json.decode(cachedData);

        // 👇 التحقق من نوع البيانات أولاً
        if (decodedData is Map<String, dynamic>) {
          final Map<String, dynamic> data = decodedData;
          final dynamic hadithsData = data['hadiths'];

          List<dynamic> hadithsJson = [];

          // 👇 معالجة أنواع البيانات المختلفة
          if (hadithsData is List) {
            hadithsJson = hadithsData;
          } else if (hadithsData is Map<String, dynamic>) {
            // لو البيانات بتكون { 'data': [...] }
            hadithsJson = hadithsData['data'] as List? ?? [];
          }

          final List<HadithModel> cachedHadiths = hadithsJson
              .map((json) => HadithModel.fromJson(json as Map<String, dynamic>))
              .toList();

          _hadithsNotifier.value = List.unmodifiable(cachedHadiths);

          // تحميل الصفحة التالية من البيانات المخزنة
          final cachedPage = data['current_page'] as int? ?? 1;
          _currentPageNotifier.value = cachedPage;

          // معرفة إذا كان هناك المزيد من الصفحات
          _hasMoreNotifier.value = data['has_more'] as bool? ?? true;

          debugPrint('تم تحميل ${cachedHadiths.length} حديث من الكاش');
        } else {
          debugPrint('صيغة البيانات المخزنة غير صحيحة');
          await _clearCache(); // مسح الكاش التالف
        }
      }
    } catch (e) {
      debugPrint('خطأ في تحميل البيانات المخزنة: $e');
      await _clearCache(); // مسح الكاش التالف
    }
  }

  // حفظ البيانات في الكاش
  Future<void> _saveToCache(
    List<HadithModel> hadiths,
    int currentPage,
    bool hasMore,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = {
        'hadiths': hadiths.map((h) => h.toJson()).toList(),
        'current_page': currentPage,
        'has_more': hasMore,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };
      await prefs.setString(_cacheKey, json.encode(data));
    } catch (e) {
      debugPrint('خطأ في حفظ البيانات: $e');
    }
  }

  // التحقق من وجود الكاش (بدون صلاحية زمنية)
  Future<bool> _isCacheValid() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedData = prefs.getString(_cacheKey);

      // 👇 مجرد وجود الكاش يبقى صالح للأبد
      return cachedData != null;
    } catch (e) {
      debugPrint('خطأ في التحقق من صلاحية الكاش: $e');
    }
    return false;
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (!_isLoadingNotifier.value && _hasMoreNotifier.value) {
        _fetchHadiths(loadMore: true);
      }
    }
  }

  Future<void> _fetchHadiths({bool loadMore = false}) async {
    if (_isLoadingNotifier.value || !_hasMoreNotifier.value) return;

    // استخدام الكاش إذا كان موجوداً ولم يكن تحميل للمزيد
    if (!loadMore && await _isCacheValid()) {
      debugPrint('استخدام البيانات المخزنة');
      return;
    }

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

        final List<HadithModel> fetchedHadiths = hadithsJson
            .map((json) => HadithModel.fromJson(json as Map<String, dynamic>))
            .toList();

        if (loadMore) {
          final currentHadiths = _hadithsNotifier.value;
          final updatedHadiths = List<HadithModel>.from(currentHadiths)
            ..addAll(fetchedHadiths);
          _hadithsNotifier.value = List.unmodifiable(updatedHadiths);
          _currentPageNotifier.value = page;
        } else {
          _hadithsNotifier.value = List.unmodifiable(fetchedHadiths);
          _currentPageNotifier.value = 1;
        }

        final bool hasMoreData = data['hadiths']['next_page_url'] != null;
        _hasMoreNotifier.value = hasMoreData;

        // حفظ البيانات في الكاش
        await _saveToCache(
          _hadithsNotifier.value,
          _currentPageNotifier.value,
          hasMoreData,
        );
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

  // دالة لمسح الكاش (اختيارية)
  Future<void> _clearCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_cacheKey);
      _hadithsNotifier.value = [];
      _currentPageNotifier.value = 1;
      _hasMoreNotifier.value = true;
      _fetchHadiths();
    } catch (e) {
      debugPrint('خطأ في مسح الكاش: $e');
    }
  }

  @override
  Widget build(BuildContext context) => Directionality(
    textDirection: TextDirection.rtl,
    child: Scaffold(
      appBar: AppBar(
        title: Text('أحاديث ${widget.chapterName}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _clearCache,
            tooltip: 'تحديث البيانات',
          ),
        ],
      ),
      body: _HadithsContent(
        hadithsNotifier: _hadithsNotifier,
        isLoadingNotifier: _isLoadingNotifier,
        hasMoreNotifier: _hasMoreNotifier,
        scrollController: _scrollController,
      ),
    ),
  );
}

// ==================== باقي الكود بدون تغيير ====================

class _HadithsContent extends StatelessWidget {
  const _HadithsContent({
    required this.hadithsNotifier,
    required this.isLoadingNotifier,
    required this.hasMoreNotifier,
    required this.scrollController,
  });

  final ValueNotifier<List<HadithModel>> hadithsNotifier;
  final ValueNotifier<bool> isLoadingNotifier;
  final ValueNotifier<bool> hasMoreNotifier;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) =>
      ValueListenableBuilder<List<HadithModel>>(
        valueListenable: hadithsNotifier,
        builder: (context, hadiths, child) => ValueListenableBuilder<bool>(
          valueListenable: isLoadingNotifier,
          builder: (context, isLoading, child) => ValueListenableBuilder<bool>(
            valueListenable: hasMoreNotifier,
            builder: (context, hasMore, child) {
              if (hadiths.isEmpty && isLoading) {
                return const _LoadingWidget();
              }

              return Scrollbar(
                controller: scrollController,
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

class _HadithsList extends StatelessWidget {
  const _HadithsList({
    required this.hadiths,
    required this.isLoading,
    required this.hasMore,
    required this.scrollController,
  });
  final List<HadithModel> hadiths;
  final bool isLoading;
  final bool hasMore;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) => ListView.builder(
    controller: scrollController,
    padding: const EdgeInsets.fromLTRB(15, 8, 8, 8),
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

class _HadithCard extends StatelessWidget {
  const _HadithCard({required this.hadith});
  final HadithModel hadith;

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
              style: theme.textTheme.titleMedium?.copyWith(height: 2),
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

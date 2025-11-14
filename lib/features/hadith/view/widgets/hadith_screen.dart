// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:http/http.dart' as http;

import '../../../../core/utils/format_helper.dart';
import '../../../../l10n/app_localizations.dart';
import '../../model/hadith_model.dart';

class HadithsScreen extends StatefulWidget {
  const HadithsScreen({
    required this.bookSlug,
    required this.chapterNumber,
    required this.chapterName,
    required this.localizations,
    this.scrollToHadithId,
    super.key,
  });

  final String bookSlug;
  final String chapterNumber;
  final String chapterName;
  final AppLocalizations localizations;
  final int? scrollToHadithId;

  @override
  State<HadithsScreen> createState() => _HadithsScreenState();
}

class _HadithsScreenState extends State<HadithsScreen> {
  static const String _apiKey =
      r'$2y$10$VRw6B1T2t5Mt7lIpICLevZU4Cn7iSFAeQLDd0FMtbH33KIf9Ge';

  final List<HadithModel> _allHadiths = [];
  final ScrollController _scrollController = ScrollController();
  final Map<int, GlobalKey> _hadithKeys = {};

  bool _isLoading = false;
  bool _initialScrollAttempted = false;
  bool _dataLoaded = false;

  List<Map<String, dynamic>> _savedHadiths = [];

  @override
  void initState() {
    super.initState();
    _loadSavedHadiths();
    _fetchAllHadiths();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadSavedHadiths() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('saved_hadiths');
    if (saved != null) {
      setState(() {
        _savedHadiths = List<Map<String, dynamic>>.from(json.decode(saved));
      });
    }
  }

  Future<void> _fetchAllHadiths() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    try {
      final hadiths = await _fetchHadithsForChapter();
      if (!mounted) return;

      setState(() {
        _allHadiths.addAll(hadiths);
        _dataLoaded = true;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${widget.localizations.errorMain} $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<List<HadithModel>> _fetchHadithsForChapter() async {
    final firstUrl = _buildApiUrl(1);
    final firstResponse = await http.get(firstUrl);

    if (firstResponse.statusCode != 200) {
      throw Exception('Failed to load hadiths');
    }

    final firstData = json.decode(firstResponse.body);
    final totalPages = firstData['hadiths']['last_page'] ?? 1;
    final List firstHadiths = firstData['hadiths']['data'] ?? [];

    final allHadiths = <HadithModel>[
      ...firstHadiths.map(
        (e) => HadithModel.fromJson(e as Map<String, dynamic>),
      ),
    ];

    if (totalPages > 1) {
      final futures = List<Future<http.Response>>.generate(
        totalPages - 1,
        (i) => http.get(_buildApiUrl(i + 2)),
      );

      final responses = await Future.wait(futures);

      for (final response in responses) {
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final List hadithsJson = data['hadiths']['data'] ?? [];
          allHadiths.addAll(
            hadithsJson
                .map((e) => HadithModel.fromJson(e as Map<String, dynamic>))
                .toList(),
          );
        }
      }
    }

    return allHadiths;
  }

  Uri _buildApiUrl(int page) => Uri.parse(
    'https://hadithapi.com/api/hadiths/?apiKey=$_apiKey&book=${widget.bookSlug}&chapter=${widget.chapterNumber}&page=$page',
  );

  void _scrollToSpecificHadith(int hadithId) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 300), () {
        final key = _hadithKeys[hadithId];
        if (key != null && key.currentContext != null) {
          Scrollable.ensureVisible(
            key.currentContext!,
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInOut,
          );
        } else if (_dataLoaded && !_isLoading) {
          // Retry after a short delay if the key isn't ready yet
          Future.delayed(const Duration(milliseconds: 500), () {
            _scrollToSpecificHadith(hadithId);
          });
        }
      });
    });
  }

  Future<void> _toggleHadithSave(HadithModel hadith, bool isArabic) async {
    final prefs = await SharedPreferences.getInstance();
    final existingIndex = _savedHadiths.indexWhere(
      (h) => h['id'].toString() == hadith.id,
    );

    if (existingIndex == -1) {
      _savedHadiths.add(_createHadithData(hadith, isArabic));
      _showSnackBar('تم حفظ الحديث رقم: ${convertToArabicNumbers(hadith.id)}');
    } else {
      _savedHadiths.removeAt(existingIndex);
      _showSnackBar(
        'تم إزالة الحديث رقم: ${convertToArabicNumbers(hadith.id)}',
      );
    }

    await prefs.setString('saved_hadiths', json.encode(_savedHadiths));
    if (mounted) setState(() {});
  }

  Map<String, dynamic> _createHadithData(HadithModel hadith, bool isArabic) => {
    'id': hadith.id,
    'heading': isArabic ? hadith.headingArabic : hadith.headingEnglish,
    'text': isArabic ? hadith.hadithArabic : hadith.hadithEnglish,
    'status': isArabic ? _statusMap[hadith.status]! : hadith.status,
    'bookSlug': widget.bookSlug,
    'chapterNumber': widget.chapterNumber,
    'chapterName': widget.chapterName,
  };

  void _showSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(content: Text(message)));
    }
  }

  Widget _buildHadithItem(
    HadithModel hadith,
    bool isArabic,
    ThemeData theme,
    AppLocalizations localization,
  ) {
    final hadithId = int.parse(hadith.id);
    final hadithText = isArabic ? hadith.hadithArabic : hadith.hadithEnglish;
    final heading = isArabic ? hadith.headingArabic : hadith.headingEnglish;
    final status = isArabic ? _statusMap[hadith.status]! : hadith.status;
    final isSaved = _savedHadiths.any((h) => h['id'].toString() == hadith.id);

    if (!_hadithKeys.containsKey(hadithId)) {
      _hadithKeys[hadithId] = GlobalKey();
    }

    return RepaintBoundary(
      key: _hadithKeys[hadithId],
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (heading.isNotEmpty)
                    Expanded(
                      child: Text(
                        heading,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.primaryColor,
                        ),
                      ),
                    ),
                  IconButton(
                    icon: Icon(
                      Icons.bookmark,
                      color: isSaved ? Colors.amber : Colors.grey,
                    ),
                    onPressed: () => _toggleHadithSave(hadith, isArabic),
                    tooltip: 'حفظ الحديث',
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                hadithText,
                style: theme.textTheme.titleMedium?.copyWith(
                  height: isArabic ? 2 : 1.4,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${localization.hadithStatus}: $status',
                textAlign: TextAlign.end,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'رقم الحديث: ${convertToArabicNumbers(hadith.id)}',
                textAlign: TextAlign.end,
                style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final isArabic = locale == 'ar';
    final localization = widget.localizations;

    if (_dataLoaded &&
        !_isLoading &&
        !_initialScrollAttempted &&
        widget.scrollToHadithId != null) {
      _initialScrollAttempted = true;
      _scrollToSpecificHadith(widget.scrollToHadithId!);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${localization.hadithsTitle} ${widget.chapterName}'),
      ),
      body: _isLoading && _allHadiths.isEmpty
          ? Skeletonizer(
              child: ListView.builder(
                padding: const EdgeInsetsDirectional.only(start: 5, end: 16),
                itemCount: 5,
                itemBuilder: (context, index) => const _SkeletonHadithItem(),
              ),
            )
          : SafeArea(
              child: Scrollbar(
                controller: _scrollController,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: const EdgeInsetsDirectional.only(start: 5, end: 16),
                  child: Column(
                    children: _allHadiths
                        .map(
                          (hadith) => _buildHadithItem(
                            hadith,
                            isArabic,
                            theme,
                            localization,
                          ),
                        )
                        .toList(),
                  ),
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
            Text('loading heading...', style: theme.textTheme.titleMedium),
            const SizedBox(height: 16),
            const Text('loading text...\nloading text...'),
            const SizedBox(height: 8),
            const Text('الحكم: ...'),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../core/utils/navigation_helper.dart';
import 'widgets/chapter_of_book.dart';
import '../helper/hadith_helper.dart';
import '../model/hadith_book_model.dart';

class HadithBooksView extends StatefulWidget {
  const HadithBooksView({super.key});

  @override
  HadithBooksViewState createState() => HadithBooksViewState();
}

class HadithBooksViewState extends State<HadithBooksView> {
  late Future<List<HadithBookModel>> booksFuture;
  String _searchText = '';

  final apiKey = r'$2y$10$VRw6B1T2t5Mt7lIpICLevZU4Cn7iSFAeQLDd0FMtbH33KIf9Ge';

  @override
  void initState() {
    super.initState();
    booksFuture = _loadBooks();
  }

  // تحميل الكتب مع كاش
  Future<List<HadithBookModel>> _loadBooks() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString('hadith_books');

    if (cachedData != null) {
      final List decoded = json.decode(cachedData);
      return decoded.map((e) => HadithBookModel.fromJson(e)).toList();
    } else {
      final books = await fetchHadithBooks();
      prefs.setString(
        'hadith_books',
        json.encode(books.map((e) => e.toJson()).toList()),
      );
      return books;
    }
  }

  // جلب الكتب من API
  Future<List<HadithBookModel>> fetchHadithBooks() async {
    final url = Uri.parse('https://hadithapi.com/api/books?apiKey=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // ignore: avoid_dynamic_calls
      final List booksJson = data['books'] ?? [];
      return booksJson.map((json) => HadithBookModel.fromJson(json)).toList();
    } else {
      throw Exception('فشل في جلب الكتب');
    }
  }

  // فلترة حسب البحث
  List<HadithBookModel> _filterBooks(List<HadithBookModel> books) {
    if (_searchText.isEmpty) return books;
    return books
        .where(
          (b) =>
              (booksArabic[b.bookName] ?? b.bookName).contains(_searchText) ||
              (writersArabic[b.writerName] ?? b.writerName).contains(
                _searchText,
              ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('كتب الحديث')),
        body: SafeArea(
          child: Column(
            children: [
              // ====== Search Bar ======
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'ابحث باسم الكتاب...',
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                  ),
                  onChanged: (val) => setState(() => _searchText = val),
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                ),
              ),

              // ====== Books List ======
              Expanded(
                child: FutureBuilder<List<HadithBookModel>>(
                  future: booksFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: theme.colorScheme.primary,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'حدث خطأ: ${snapshot.error}',
                          style: theme.textTheme.bodyMedium,
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          'لا توجد كتب',
                          style: theme.textTheme.bodyMedium,
                        ),
                      );
                    }

                    final books = _filterBooks(snapshot.data!);

                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      itemCount: books.length,
                      itemBuilder: (context, index) {
                        final book = books[index];

                        final nameAr =
                            booksArabic[book.bookName] ?? book.bookName;
                        final writerAr =
                            writersArabic[book.writerName] ?? book.writerName;

                        return book.hadithCount != '0'
                            ? Card(
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: () {
                                    navigateWithTransition(
                                      type: TransitionType.fade,
                                      context,
                                      ChapterOfBook(
                                        bookSlug: book.bookSlug,
                                        bookName:
                                            booksArabic[book.bookName] ??
                                            book.bookName,
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      children: [
                                        // دائرة فيها رقم الكتاب
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: theme.primaryColor.withAlpha(
                                              (0.1 * 255).toInt(),
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Text(
                                            book.id,
                                            style: theme.textTheme.titleMedium
                                                ?.copyWith(
                                                  color: theme.primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ),
                                        const SizedBox(width: 16),

                                        // تفاصيل الكتاب
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                nameAr,
                                                style: theme
                                                    .textTheme
                                                    .titleMedium
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                'الكاتب: $writerAr',
                                                style:
                                                    theme.textTheme.bodySmall,
                                              ),
                                              Text(
                                                'عدد الأبواب: ${book.chapterCount} - عدد الأحاديث: ${book.hadithCount}',
                                                style:
                                                    theme.textTheme.bodySmall,
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
                              )
                            : const SizedBox.shrink();
                      },
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
}

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'chapter_screen.dart';

class HadithBook {
  HadithBook({
    required this.id,
    required this.bookName,
    required this.writerName,
    required this.hadithCount,
    required this.chapterCount,
    required this.writerDeath,
    required this.bookSlug,
  });

  factory HadithBook.fromJson(Map<String, dynamic> json) => HadithBook(
    id: json['id'].toString(),
    bookName: json['bookName'] ?? '',
    writerName: json['writerName'],
    hadithCount: json['hadiths_count'],
    chapterCount: json['chapters_count'],
    writerDeath: json['writerDeath'],
    bookSlug: json['bookSlug'],
  );
  final String id;
  final String bookName;
  final String writerName;
  final String hadithCount;
  final String chapterCount;
  final String writerDeath;
  final String bookSlug;
}

class HadithBooksScreen extends StatefulWidget {
  const HadithBooksScreen({super.key});

  @override
  HadithBooksScreenState createState() => HadithBooksScreenState();
}

class HadithBooksScreenState extends State<HadithBooksScreen> {
  late Future<List<HadithBook>> booksFuture;
  String _searchText = '';

  final Map<String, String> booksArabic = {
    'Sahih Bukhari': 'صحيح البخاري',
    'Sahih Muslim': 'صحيح مسلم',
    "Jami' Al-Tirmidhi": 'جامع الترمذي',
    'Sunan Abu Dawood': 'سنن أبي داود',
    'Sunan Ibn-e-Majah': 'سنن ابن ماجه',
    'Sunan An-Nasa`i': 'سنن النسائي',
    'Mishkat Al-Masabih': 'مشكاة المصابيح',
    'Musnad Ahmad': 'مسند أحمد',
    'Al-Silsila Sahiha': 'السلسلة الصحيحة',
  };

  final Map<String, String> writersArabic = {
    'Imam Bukhari': 'الإمام البخاري',
    'Imam Muslim': 'الإمام مسلم',
    'Abu `Isa Muhammad at-Tirmidhi': 'الإمام أبو عيسى محمد الترمذي',
    "Imam Abu Dawud Sulayman ibn al-Ash'ath as-Sijistani":
        'الإمام أبو داود سليمان بن الأشعث السجستاني',
    'Imam Muhammad bin Yazid Ibn Majah al-Qazvini':
        'الإمام محمد بن يزيد ابن ماجه القزويني',
    'Imam Ahmad an-Nasa`i': 'الإمام أحمد النسائي',
    'Imam Khatib at-Tabrizi': 'الإمام الخطيب التبريزي',
    'Imam Ahmad ibn Hanbal': 'الإمام أحمد بن حنبل',
    'Allama Muhammad Nasir Uddin Al-Bani': 'العلامة محمد ناصر الدين الألباني',
  };

  @override
  void initState() {
    super.initState();
    booksFuture = fetchHadithBooks();
  }

  final apiKey = r'$2y$10$VRw6B1T2t5Mt7lIpICLevZU4Cn7iSFAeQLDd0FMtbH33KIf9Ge';

  Future<List<HadithBook>> fetchHadithBooks() async {
    final url = Uri.parse('https://hadithapi.com/api/books?apiKey=$apiKey');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // ignore: avoid_dynamic_calls
      final List booksJson = data['books'] ?? [];

      return booksJson.map((json) => HadithBook.fromJson(json)).toList();
    } else {
      throw Exception('فشل في جلب الكتب');
    }
  }

  // فلترة حسب البحث
  List<HadithBook> _filterBooks(List<HadithBook> books) {
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
                  horizontal: 16,
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
                child: FutureBuilder<List<HadithBook>>(
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
                      padding: const EdgeInsets.symmetric(horizontal: 12),
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
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ChaptersScreen(
                                          bookSlug: book.bookSlug,
                                          bookName:
                                              booksArabic[book.bookName] ??
                                              book.bookName,
                                        ),
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
                                                'المؤلف: $writerAr',
                                                style: theme.textTheme.bodySmall
                                                    ?.copyWith(),
                                              ),
                                              Text(
                                                'عدد الأبواب: ${book.chapterCount} - عدد الأحاديث: ${book.hadithCount}',
                                                style: theme.textTheme.bodySmall
                                                    ?.copyWith(),
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

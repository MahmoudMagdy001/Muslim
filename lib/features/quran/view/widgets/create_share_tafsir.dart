// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

// مدير الكاش للصور
class ImageCacheManager {
  static final Map<String, Uint8List> _cache = {};

  static Future<Uint8List> getImage(String path) async {
    if (_cache.containsKey(path)) {
      return _cache[path]!;
    }

    final data = await rootBundle.load(path);
    final bytes = data.buffer.asUint8List();
    _cache[path] = bytes;
    return bytes;
  }

  static void clearCache() {
    _cache.clear();
  }
}

// الدالة الرئيسية مع جميع التحسينات
Future<void> createAndShareTafsirImage({
  required String surahName,
  required int ayahNumber,
  required String ayahText,
  required String tafsirTitle,
  required String tafsirText,
  required bool isArabic,
  required BuildContext context,
}) async {
  // إظهار مؤشر التحميل
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      content: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(width: 20),
          Text(
            isArabic ? 'جاري إنشاء الصور...' : 'Creating images...',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    ),
  );

  try {
    final screenshotController = ScreenshotController();

    // تحميل البسملة مع الكاش
    final basmalaBytes = await ImageCacheManager.getImage(
      'assets/images/basmalah.png',
    );

    // تقسيم النص أولاً
    final List<String> tafsirParts = _splitTafsirText(tafsirText);
    final List<File> imageFiles = [];

    // إنشاء جميع الـ widgets مسبقاً
    final widgets = List.generate(
      tafsirParts.length,
      (i) => _buildTafsirWidget(
        surahName: surahName,
        ayahNumber: ayahNumber,
        ayahText: ayahText,
        tafsirTitle: tafsirTitle,
        tafsirPart: tafsirParts[i],
        partIndex: i,
        totalParts: tafsirParts.length,
        basmalaBytes: basmalaBytes,
        isArabic: isArabic,
        context: context,
      ),
    );

    // التقاط الصور بشكل متوازي مع إعدادات محسنة
    final captures = await Future.wait(
      widgets.map(
        (widget) => screenshotController.captureFromWidget(
          MediaQuery(
            data: const MediaQueryData(),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(backgroundColor: Colors.white, body: widget),
            ),
          ),
          delay: const Duration(milliseconds: 50), // تقليل وقت الانتظار
          pixelRatio: 1.5, // تقليل دقة الصورة لتسريع العملية
        ),
      ),
    );

    // حفظ الصور بشكل متوازي
    final dir = await getTemporaryDirectory();
    final saveOperations = <Future<File>>[];

    for (int i = 0; i < captures.length; i++) {
      final operation = _saveImageFile(
        dir: dir,
        imageData: captures[i],
        surahName: surahName,
        ayahNumber: ayahNumber,
        index: i,
      );
      saveOperations.add(operation);
    }

    final savedFiles = await Future.wait(saveOperations);
    imageFiles.addAll(savedFiles);

    // إغلاق مؤشر التحميل
    if (context.mounted) {
      Navigator.of(context).pop();
    }

    // المشاركة
    final shareTextMessage = isArabic
        ? '📖 تفسير سورة $surahName - الآية ${_convertToArabicNumbers(ayahNumber)} (${tafsirParts.length} ${tafsirParts.length == 1 ? 'صورة' : 'صور'})'
        : '📖 Tafsir $surahName - Verse $ayahNumber (${tafsirParts.length} ${tafsirParts.length == 1 ? 'image' : 'images'})';

    final List<XFile> xFiles = imageFiles
        .map((file) => XFile(file.path))
        .toList();

    await SharePlus.instance.share(
      ShareParams(
        files: xFiles,
        text: shareTextMessage,
        subject: isArabic ? 'تفسير القرآن' : 'Quran Tafsir',
      ),
    );
  } catch (error) {
    // إغلاق مؤشر التحميل في حالة الخطأ
    if (context.mounted) {
      Navigator.of(context).pop();

      // إظهار رسالة خطأ
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(isArabic ? 'خطأ' : 'Error'),
          content: Text(
            isArabic
                ? 'حدث خطأ أثناء إنشاء الصور: $error'
                : 'An error occurred while creating images: $error',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(isArabic ? 'موافق' : 'OK'),
            ),
          ],
        ),
      );
    }
  }
}

// دالة مساعدة لحفظ الصور
Future<File> _saveImageFile({
  required Directory dir,
  required Uint8List imageData,
  required String surahName,
  required int ayahNumber,
  required int index,
}) async {
  final file = File(
    '${dir.path}/tafsir_${surahName}_$ayahNumber${index + 1}.png',
  );
  await file.writeAsBytes(imageData);
  return file;
}

// دالة منفصلة لبناء الـ widget
Widget _buildTafsirWidget({
  required String surahName,
  required int ayahNumber,
  required String ayahText,
  required String tafsirTitle,
  required String tafsirPart,
  required int partIndex,
  required int totalParts,
  required Uint8List basmalaBytes,
  required bool isArabic,
  required BuildContext context,
}) => Directionality(
  textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
  child: Container(
    width: 1000,
    height: 1300,
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // العنوان الرئيسي
        if (partIndex == 0) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  isArabic
                      ? 'سورة $surahName - الآية رقم ${_convertToArabicNumbers(ayahNumber)}'
                      : 'Surah $surahName - Verse $ayahNumber',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue[800],
                  ),
                ),
              ),

              Text(
                tafsirTitle,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue[800],
                ),
              ),
            ],
          ),
        ],
        const SizedBox(height: 10),

        // البسملة (في الصورة الأولى فقط)
        if (partIndex == 0) ...[
          Center(
            child: Image.memory(
              basmalaBytes,
              width: 250,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
        ],

        // نص الآية (في الصورة الأولى فقط)
        if (partIndex == 0) ...[
          Text(
            ayahText,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 20,
              height: 2.1,
              color: Colors.black87,
            ),

            textAlign: isArabic ? TextAlign.right : TextAlign.left,
          ),
          const SizedBox(height: 10),
        ],

        // نص التفسير
        Flexible(
          child: SingleChildScrollView(
            child: Text(
              tafsirPart,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.4,
              ),
              textAlign: TextAlign.start,
            ),
          ),
        ),
        const SizedBox(height: 5),
        // الخط الفاصل والمعلومات
        const Divider(color: Colors.grey, height: 1),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            isArabic
                ? '${totalParts > 1 ? 'الصفحة ${_convertToArabicNumbers(partIndex + 1)} من ${_convertToArabicNumbers(totalParts)} - ' : ''}تمت المشاركة من تطبيق مُسَلِّم'
                : '${totalParts > 1 ? 'Page ${partIndex + 1} of $totalParts - ' : ''}Shared from Muslim App',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  ),
);

// تحسين دالة تقسيم النص
List<String> _splitTafsirText(String text, {int maxCharsPerPart = 1500}) {
  if (text.isEmpty) return [''];

  if (text.length <= maxCharsPerPart) return [text];

  final List<String> parts = [];
  // تقسيم النص على الجمل أو الفواصل الكبيرة
  final sentences = text.split(RegExp(r'(?<=[.؟،])'));

  String currentPart = '';

  for (final sentence in sentences) {
    final trimmed = sentence.trim();
    if (trimmed.isEmpty) continue;

    // إذا الجملة أطول من الحد الأقصى، نقسمها
    if (trimmed.length > maxCharsPerPart) {
      if (currentPart.isNotEmpty) {
        parts.add(currentPart.trim());
        currentPart = '';
      }
      parts.addAll(_splitLongSentence(trimmed, maxCharsPerPart));
    }
    // إذا يمكن إضافتها للجزء الحالي
    else if (('$currentPart $trimmed').trim().length <= maxCharsPerPart) {
      currentPart = ('$currentPart $trimmed').trim();
    }
    // إنشاء جزء جديد
    else {
      if (currentPart.isNotEmpty) parts.add(currentPart.trim());
      currentPart = trimmed;
    }
  }

  if (currentPart.isNotEmpty) parts.add(currentPart.trim());

  return parts;
}

List<String> _splitLongSentence(String sentence, int maxChars) {
  if (sentence.length <= maxChars) return [sentence];

  final List<String> parts = [];
  int start = 0;

  while (start < sentence.length) {
    final int end = start + maxChars;
    if (end >= sentence.length) {
      parts.add(sentence.substring(start).trim());
      break;
    }

    // نبحث عن آخر فاصل طبيعي قبل الحد الأقصى
    int breakIndex = sentence.lastIndexOf(RegExp(r'[ ,،.؟]'), end);
    if (breakIndex <= start) breakIndex = end;

    parts.add(sentence.substring(start, breakIndex).trim());
    start = breakIndex;
  }

  return parts;
}

// دالة تحويل الأرقام للعربية
String _convertToArabicNumbers(int number) {
  const english = '0123456789';
  const arabic = '٠١٢٣٤٥٦٧٨٩';
  final s = number.toString();
  return s.split('').map((c) {
    final idx = english.indexOf(c);
    return idx >= 0 ? arabic[idx] : c;
  }).join();
}

// دالة لتنظيف الملفات المؤقتة (اختيارية)
Future<void> clearTemporaryTafsirImages() async {
  try {
    final dir = await getTemporaryDirectory();
    final files = dir.listSync();

    for (final file in files) {
      if (file is File && file.path.contains('tafsir_')) {
        await file.delete();
      }
    }
  } catch (e) {
    debugPrint('Error clearing temporary files: $e');
  }
}

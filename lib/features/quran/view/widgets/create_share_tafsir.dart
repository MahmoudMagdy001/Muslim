// ignore_for_file: avoid_classes_with_only_static_members, parameter_assignments

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../core/utils/extensions.dart';

// مدير الكاش للصور مع حد أقصى للذاكرة
class ImageCacheManager {
  static final Map<String, Uint8List> _cache = {};
  static const int maxCacheSize = 10 * 1024 * 1024; // 10 MB
  static int _currentCacheSize = 0;

  static Future<Uint8List> getImage(String path) async {
    if (_cache.containsKey(path)) {
      return _cache[path]!;
    }

    final data = await rootBundle.load(path);
    final bytes = data.buffer.asUint8List();

    // التحقق من حجم الكاش
    if (_currentCacheSize + bytes.length > maxCacheSize) {
      clearCache();
    }

    _cache[path] = bytes;
    _currentCacheSize += bytes.length;
    return bytes;
  }

  static void clearCache() {
    _cache.clear();
    _currentCacheSize = 0;
  }

  static int getCacheSize() => _currentCacheSize;
}

// نتيجة العملية
class ShareResult {
  ShareResult({
    required this.success,
    this.errorMessage,
    this.imagesCreated = 0,
  });
  final bool success;
  final String? errorMessage;
  final int imagesCreated;
}

// الدالة الرئيسية المحسنة
Future<ShareResult> createAndShareTafsirImage({
  required String surahName,
  required int ayahNumber,
  required String ayahText,
  required String tafsirTitle,
  required String tafsirText,
  required bool isArabic,
  required BuildContext context,
}) async {
  // التحقق من صحة المدخلات
  if (tafsirText.trim().isEmpty) {
    return ShareResult(
      success: false,
      errorMessage: isArabic ? 'نص التفسير فارغ' : 'Tafsir text is empty',
    );
  }

  // إظهار مؤشر التحميل
  if (context.mounted) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 20),
              Flexible(
                child: Text(
                  isArabic ? 'جاري إنشاء الصور...' : 'Creating images...',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  try {
    final screenshotController = ScreenshotController();

    // Capture theme data to ensure generated images match app design
    final titleLargeStyle = context.textTheme.titleLarge;
    final titleMediumStyle = context.textTheme.titleMedium;

    final textDirection = isArabic ? TextDirection.rtl : TextDirection.ltr;

    // تقسيم النص
    final List<String> tafsirParts = _splitTafsirText(tafsirText);

    if (tafsirParts.isEmpty) {
      throw Exception(
        isArabic ? 'فشل تقسيم نص التفسير' : 'Failed to split tafsir text',
      );
    }

    // تنظيف الملفات المؤقتة القديمة قبل البدء
    await clearTemporaryTafsirImages();

    final dir = await getTemporaryDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final safeSurahName = surahName.replaceAll(RegExp(r'[^\w\s]+'), '');
    final imageFiles = <File>[];

    // دالة مساعدة لالتقاط وحفظ الصورة فوراً (توفير الذاكرة)
    Future<void> captureAndSave(Widget widget, int index) async {
      try {
        final capture = await screenshotController.captureFromWidget(
          MediaQuery(
            data: const MediaQueryData(),
            child: Directionality(
              textDirection: textDirection,
              child: Scaffold(backgroundColor: Colors.white, body: widget),
            ),
          ),
          delay: const Duration(milliseconds: 50), // Reduced delay for speed
          pixelRatio: 2.0, // Higher quality
          context: context,
        );

        final file = File(
          '${dir.path}/tafsir_${safeSurahName}_${ayahNumber}_${index}_$timestamp.png',
        );
        await file.writeAsBytes(capture);
        imageFiles.add(file);
      } catch (e) {
        debugPrint('Error capturing widget index $index: $e');
        throw Exception(
          isArabic ? 'فشل إنشاء الصورة' : 'Failed to generate image',
        );
      }
    }

    // 1. الصفحة الأولى (البسملة والآية)
    final firstPageWidget = _buildFirstPageWidget(
      surahName: surahName,
      ayahNumber: ayahNumber,
      ayahText: ayahText,
      tafsirTitle: tafsirTitle,
      isArabic: isArabic,
      titleLargeStyle: titleLargeStyle,
      titleMediumStyle: titleMediumStyle,
    );
    await captureAndSave(firstPageWidget, 0);

    // 2. صفحات التفسير
    for (int i = 0; i < tafsirParts.length; i++) {
      final tafsirWidget = _buildTafsirWidget(
        tafsirPart: tafsirParts[i],
        partIndex: i,
        totalParts: tafsirParts.length,
        isArabic: isArabic,
      );
      await captureAndSave(tafsirWidget, i + 1);
    }

    // إغلاق مؤشر التحميل
    if (context.mounted) {
      Navigator.of(context).pop();
    }

    // المشاركة
    final totalImages = imageFiles.length;
    final shareTextMessage = isArabic
        ? '📖 تفسير سورة $surahName - الآية ${_convertToArabicNumbers(ayahNumber)}\n'
              '${totalImages > 1 ? '(${_convertToArabicNumbers(totalImages)} ${totalImages == 2 ? 'صورتان' : 'صور'})' : ''}'
        : '📖 Tafsir $surahName - Verse $ayahNumber\n'
              '${totalImages > 1 ? '($totalImages images)' : ''}';

    final List<XFile> xFiles = imageFiles
        .map((file) => XFile(file.path))
        .toList();

    try {
      await SharePlus.instance.share(
        ShareParams(
          files: xFiles,
          text: shareTextMessage,
          subject: 'تفسير القرآن الكريم',
        ),
      );

      // لا نحذف الملفات فوراً لأن المشاركة قد تحتاجها
      // سيتم تنظيفها في المرة القادمة عند استدعاء الدالة

      return ShareResult(success: true, imagesCreated: imageFiles.length);
    } catch (e) {
      throw Exception(
        isArabic ? 'فشل مشاركة الصور: $e' : 'Failed to share images: $e',
      );
    }
  } catch (error) {
    // إغلاق مؤشر التحميل
    if (context.mounted && Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }

    // إظهار رسالة خطأ
    if (context.mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            isArabic ? '⚠️ خطأ' : '⚠️ Error',
            style: const TextStyle(color: Colors.red),
          ),
          content: Text(error.toString().replaceAll('Exception: ', '')),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(isArabic ? 'موافق' : 'OK'),
            ),
          ],
        ),
      );
    }

    return ShareResult(success: false, errorMessage: error.toString());
  }
}

// دالة لبناء الصفحة الأولى (البسملة والآية) - حجم أصغر وتصميم أجمل
Widget _buildFirstPageWidget({
  required String surahName,
  required int ayahNumber,
  required String ayahText,
  required String tafsirTitle,
  required bool isArabic,
  required TextStyle? titleLargeStyle,
  required TextStyle? titleMediumStyle,
}) => Directionality(
  textDirection: TextDirection.rtl,
  child: Container(
    width: 1080,
    height: 1400,
    padding: const EdgeInsets.all(32),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFF8F9FA), Color(0xFFE9ECEF)],
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha((0.1 * 255).toInt()),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // اسم السورة ورقم الآية
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF4A90E2).withAlpha((0.3 * 255).toInt()),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            'سورة $surahName - الآية ${_convertToArabicNumbers(ayahNumber)}',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        const SizedBox(height: 24),

        // اسم التفسير
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF27AE60), Color(0xFF229954)],
            ),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF27AE60).withAlpha((0.3 * 255).toInt()),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            tafsirTitle,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        const SizedBox(height: 32),

        // البسملة والآية في نفس الـ container مع تعديل المسافة
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha((0.05 * 255).toInt()),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // البسملة كنص بتصميم جميل
              Text(
                'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
                style: titleLargeStyle?.copyWith(color: Colors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  ayahText,
                  style: titleMediumStyle?.copyWith(
                    color: Colors.black,
                    height: 2.1,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);

// دالة لبناء صفحات التفسير
Widget _buildTafsirWidget({
  required String tafsirPart,
  required int partIndex,
  required int totalParts,
  required bool isArabic,
}) => Directionality(
  textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
  child: Container(
    width: 1080,
    height: 1400,
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade200, width: 2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // المحتوى الرئيسي
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: SingleChildScrollView(
              child: Text(
                tafsirPart,
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.black87,
                  height: 1.5,
                  letterSpacing: 0.2,
                ),
                textAlign: isArabic ? TextAlign.justify : TextAlign.left,
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        // الفوتر
        Column(
          children: [
            Divider(color: Colors.grey[400], height: 1, thickness: 1),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isArabic
                        ? 'صفحة ${_convertToArabicNumbers(partIndex + 1)} من ${_convertToArabicNumbers(totalParts)}'
                        : 'Page ${partIndex + 1} of $totalParts',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.blue[800],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  isArabic ? 'تطبيق مُسَلِّم' : 'Muslim App',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ),
);

// تحسين دالة تقسيم النص - بناءً على عدد الأسطر المتاحة
List<String> _splitTafsirText(String text, {int maxCharsPerPart = 1320}) {
  if (text.isEmpty) return [''];

  text = text.trim().replaceAll(RegExp(r'\s+'), ' ');

  if (text.length <= maxCharsPerPart) return [text];

  final List<String> parts = [];
  int startIndex = 0;

  while (startIndex < text.length) {
    // حساب نهاية الجزء الحالي
    final int endIndex = startIndex + maxCharsPerPart;

    // إذا وصلنا لنهاية النص
    if (endIndex >= text.length) {
      final remaining = text.substring(startIndex).trim();
      if (remaining.isNotEmpty) {
        parts.add(remaining);
      }
      break;
    }

    // البحث عن أفضل مكان للقطع (جملة كاملة)
    int bestCutIndex = endIndex;

    // أولاً: البحث عن نهاية جملة (. أو ؟ أو !)
    final sentenceEndIndex = text.lastIndexOf(RegExp(r'[.؟!]'), endIndex);
    if (sentenceEndIndex > startIndex && (endIndex - sentenceEndIndex) < 100) {
      bestCutIndex = sentenceEndIndex + 1;
    }
    // ثانياً: البحث عن فاصلة أو فاصلة عربية
    else {
      final commaIndex = text.lastIndexOf(RegExp(r'[،,;]'), endIndex);
      if (commaIndex > startIndex && (endIndex - commaIndex) < 100) {
        bestCutIndex = commaIndex + 1;
      }
      // ثالثاً: البحث عن مسافة
      else {
        final spaceIndex = text.lastIndexOf(' ', endIndex);
        if (spaceIndex > startIndex && spaceIndex > startIndex + 100) {
          bestCutIndex = spaceIndex + 1;
        }
      }
    }

    // إضافة الجزء
    final part = text.substring(startIndex, bestCutIndex).trim();
    if (part.isNotEmpty) {
      parts.add(part);
    }

    // الانتقال للجزء التالي
    startIndex = bestCutIndex;

    // تخطي المسافات في البداية
    while (startIndex < text.length && text[startIndex] == ' ') {
      startIndex++;
    }
  }

  // التحقق من عدم فقدان النص
  debugPrint('📊 Split results:');
  debugPrint('Original length: ${text.length}');
  final int totalReconstructed = parts.fold<int>(
    0,
    (sum, part) => sum + part.length,
  );
  debugPrint('Total in parts: $totalReconstructed');
  debugPrint('Number of parts: ${parts.length}');

  // طباعة أول وآخر 50 حرف من كل جزء
  for (int i = 0; i < parts.length; i++) {
    final part = parts[i];
    final preview = part.length > 50 ? part.substring(0, 50) : part;
    final ending = part.length > 50 ? part.substring(part.length - 50) : '';
    debugPrint('Part ${i + 1} (${part.length} chars):');
    debugPrint('  Start: $preview...');
    if (ending.isNotEmpty) {
      debugPrint('  End: ...$ending');
    }
  }

  return parts.isEmpty ? [text] : parts;
}

// تحويل الأرقام للعربية
String _convertToArabicNumbers(int number) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

  return number.toString().split('').map((char) {
    final index = english.indexOf(char);
    return index >= 0 ? arabic[index] : char;
  }).join();
}

// تنظيف الملفات المؤقتة
Future<void> clearTemporaryTafsirImages() async {
  try {
    final dir = await getTemporaryDirectory();
    final files = dir.listSync();

    for (final file in files) {
      if (file is File && file.path.contains('tafsir_')) {
        try {
          await file.delete();
        } catch (e) {
          debugPrint('Failed to delete file: ${file.path}');
        }
      }
    }

    // تنظيف الكاش أيضاً
    ImageCacheManager.clearCache();
  } catch (e) {
    debugPrint('Error clearing temporary files: $e');
  }
}

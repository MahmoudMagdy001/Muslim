// widgets/surah_text_view_horizontal.dart
import 'dart:async';
import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:quran/quran.dart' as quran;

import '../../../../core/utils/custom_modal_sheet.dart';
import '../../viewmodel/quran_player_cubit/quran_player_cubit.dart';
import '../../viewmodel/bookmarks_cubit/bookmarks_cubit.dart';

class SurahTextView extends StatefulWidget {
  const SurahTextView({required this.surahNumber, this.startAyah, super.key});

  final int surahNumber;
  final int? startAyah;

  @override
  State<SurahTextView> createState() => _SurahTextViewState();
}

class _SurahTextViewState extends State<SurahTextView> {
  final ScrollController _controller = ScrollController();
  GlobalKey? _currentKey;
  int? _currentAyah;
  StreamSubscription? _playerSub;
  final Map<int, GlobalKey> _ayahKeys = {};
  List<InlineSpan>? _cachedSpans;
  int? _cachedSurahNumber;
  int? _cachedCurrentAyah;

  String? tafsir;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _playerSub ??= context.read<QuranPlayerCubit>().stream.listen((
      playerState,
    ) {
      final newAyah = playerState.currentAyah;
      if (!mounted) return;
      if (newAyah != null && newAyah != _currentAyah) {
        setState(() => _currentAyah = newAyah);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToCurrentAyah();
        });
      }
    });

    if (widget.startAyah != null && widget.startAyah! > 1) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToAyah(widget.startAyah!);
      });
    }
  }

  void _scrollToAyah(int ayahNumber) {
    final key = _ayahKeys[ayahNumber];
    if (key == null) return;

    final ctx = key.currentContext;
    if (ctx == null) return;

    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 200),
      alignment: 0.4,
    );
  }

  @override
  void dispose() {
    _playerSub?.cancel();
    _controller.dispose();
    super.dispose();
  }

  /// ✅ جلب التفسير من API
  Future<String?> fetchTafsirById(int tafsirId, int surah, int ayah) async {
    try {
      final url = Uri.parse(
        'http://api.quran-tafseer.com/tafseer/$tafsirId/$surah/$ayah/$ayah',
      );

      final response = await http.get(url);

      if (response.statusCode != 200) {
        return 'حدث خطأ أثناء تحميل التفسير (${response.statusCode}).';
      }

      final List<dynamic> data = jsonDecode(response.body);

      if (data.isEmpty) {
        return 'لم يتم العثور على تفسير لهذه الآية.';
      }

      final tafsir = data.first;
      final text = tafsir['text']?.toString().trim() ?? '';
      return text.isNotEmpty ? text : 'لم يتم العثور على تفسير لهذه الآية.';
    } catch (e) {
      print('Tafsir error: $e');
      return 'تعذر جلب التفسير. تأكد من الاتصال بالإنترنت.';
    }
  }

  /// 🕌 قائمة المفسرين المدعومين
  final List<Map<String, dynamic>> tafasirList = [
    {'id': 1, 'name': 'التفسير الميسر'},
    {'id': 2, 'name': 'تفسير الجلالين'},
    {'id': 3, 'name': 'تفسير السعدي'},
    {'id': 4, 'name': 'تفسير ابن كثير'},
    {'id': 5, 'name': 'تفسير الوسيط لطنطاوي'},
    {'id': 6, 'name': 'تفسير البغوي'},
    {'id': 7, 'name': 'تفسير القرطبي'},
    {'id': 8, 'name': 'تفسير الطبري'},
  ];

  List<InlineSpan> _buildSpans(BuildContext context) {
    final adjustedAyah = _currentAyah;

    if (_cachedSpans != null &&
        _cachedSurahNumber == widget.surahNumber &&
        _cachedCurrentAyah == adjustedAyah) {
      return _cachedSpans!;
    }

    final ayahCount = quran.getVerseCount(widget.surahNumber);
    final spans = <InlineSpan>[];
    _currentKey = null;

    for (int ayah = 1; ayah <= ayahCount; ayah++) {
      final endSymbol = quran.getVerseEndSymbol(ayah);
      final text = quran.getVerse(widget.surahNumber, ayah);

      final isCurrent = ayah == adjustedAyah;
      final keyForThisAyah = isCurrent
          ? (_currentKey = GlobalKey())
          : GlobalKey();
      _ayahKeys[ayah] = keyForThisAyah;

      spans.add(
        TextSpan(
          children: [
            WidgetSpan(
              alignment: PlaceholderAlignment.top,
              child: SizedBox(key: keyForThisAyah, width: 0, height: 0),
            ),
            TextSpan(
              text: '$text ',
              style: GoogleFonts.amiri().copyWith(
                color: isCurrent
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).textTheme.bodyLarge?.color,
              ),
              recognizer: _createGestureRecognizer(ayah, text),
            ),
            TextSpan(text: endSymbol, style: GoogleFonts.amiri()),
            const TextSpan(text: ' '),
          ],
        ),
      );
    }

    _cachedSpans = spans;
    _cachedSurahNumber = widget.surahNumber;
    _cachedCurrentAyah = adjustedAyah;

    return spans;
  }

  TapGestureRecognizer _createGestureRecognizer(int ayah, String text) {
    final tapRecognizer = TapGestureRecognizer();
    Offset? tapPosition;

    tapRecognizer
      ..onTapDown = (details) {
        tapPosition = details.globalPosition;
      }
      ..onTap = () async {
        final overlay =
            Overlay.of(context).context.findRenderObject() as RenderBox;
        final position = tapPosition ?? Offset.zero;
        final menuPosition = RelativeRect.fromLTRB(
          position.dx,
          position.dy,
          overlay.size.width - position.dx,
          overlay.size.height - position.dy,
        );

        final selected = await showMenu<String>(
          context: context,
          position: menuPosition,
          items: const [
            PopupMenuItem(value: 'play', child: Text('تشغيل من هذه الآية')),
            PopupMenuItem(
              value: 'bookmark',
              child: Text('حفظ علامة على هذه الآية'),
            ),
            PopupMenuItem(value: 'tafseer', child: Text('تفسير')),
          ],
        );

        if (selected == 'play') {
          if (mounted) {
            context.read<QuranPlayerCubit>().seek(
              Duration.zero,
              index: ayah - 1,
            );
            context.read<QuranPlayerCubit>().play();
          }
        } else if (selected == 'bookmark') {
          if (mounted) {
            context.read<BookmarksCubit>().addBookmark(
              surah: widget.surahNumber,
              ayah: ayah,
              ayahText: text,
            );

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('تم حفظ علامة على آية رقم $ayah'),
                duration: const Duration(seconds: 2),
              ),
            );
          }
        } else if (selected == 'tafseer') {
          if (!mounted) return;

          final selectedTafsir = await showDialog<Map<String, dynamic>>(
            fullscreenDialog: true,
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('اختر التفسير', textAlign: TextAlign.center),
              content: SizedBox(
                width: double.maxFinite,
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: tafasirList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                    childAspectRatio: 1.9,
                  ),
                  itemBuilder: (context, index) {
                    final tafsir = tafasirList[index];
                    return InkWell(
                      onTap: () => Navigator.pop(context, tafsir),
                      borderRadius: BorderRadius.circular(12),
                      child: Center(
                        child: Text(
                          tafsir['name'],
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                              ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );

          if (selectedTafsir == null) return;

          // ✅ عرض مؤشر تحميل أثناء جلب التفسير
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );

          final tafsirText = await fetchTafsirById(
            selectedTafsir['id'],
            widget.surahNumber,
            ayah,
          );

          if (mounted) Navigator.pop(context);

          if (mounted) {
            showCustomModalBottomSheet(
              context: context,
              isScrollControlled: true,
              minChildSize: 0.3,
              initialChildSize: 0.7,
              maxChildSize: 0.9,
              builder: (context) => SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      '${selectedTafsir['name']} - للآية رقم $ayah',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      tafsirText ?? 'لا يوجد تفسير متاح حاليًا.',
                      textAlign: TextAlign.justify,
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(height: 1.7),
                    ),
                  ],
                ),
              ),
            );
          }
        }
      };

    return tapRecognizer;
  }

  void _scrollToCurrentAyah() {
    if (_currentKey == null) return;
    final ctx = _currentKey!.currentContext;
    if (ctx == null) return;

    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 400),
      alignment: 0.4,
    );
  }

  @override
  Widget build(BuildContext context) => Scrollbar(
    controller: _controller,
    child: SingleChildScrollView(
      controller: _controller,
      padding: const EdgeInsetsDirectional.only(
        start: 6,
        end: 18,
        top: 5,
        bottom: 5,
      ),
      child: RepaintBoundary(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              height: 2.3,
              fontWeight: FontWeight.normal,
            ),
            children: _buildSpans(context),
          ),
        ),
      ),
    ),
  );
}

// widgets/surah_text_view_horizontal.dart
import 'dart:async';
import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:quran/quran.dart' as quran;
import 'package:share_plus/share_plus.dart';

import '../../../../core/utils/custom_modal_sheet.dart';
import '../../../../core/utils/format_helper.dart';
import '../../../../l10n/app_localizations.dart';
import '../../viewmodel/quran_player_cubit/quran_player_cubit.dart';
import '../../viewmodel/bookmarks_cubit/bookmarks_cubit.dart';

class SurahTextView extends StatefulWidget {
  const SurahTextView({
    required this.surahNumber,
    required this.isArabic,
    required this.localizations,
    this.startAyah,
    super.key,
  });

  final int surahNumber;
  final int? startAyah;
  final AppLocalizations localizations;
  final bool isArabic;

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

      // ignore: avoid_dynamic_calls
      final text = tafsir['text']?.toString().trim() ?? '';
      return text.isNotEmpty ? text : 'لم يتم العثور على تفسير لهذه الآية.';
    } catch (e) {
      debugPrint('===========> $e');
      return 'تعذر جلب التفسير. تأكد من الاتصال بالإنترنت.';
    }
  }

  /// 🕌 قائمة المفسرين المدعومين
  final List<Map<String, dynamic>> tafasirList = [
    {'id': 1, 'name_ar': 'التفسير الميسر', 'name_en': 'Al-Muyassar Tafsir'},
    {'id': 2, 'name_ar': 'تفسير الجلالين', 'name_en': 'Tafsir Al-Jalalayn'},
    {'id': 3, 'name_ar': 'تفسير السعدي', 'name_en': 'Tafsir As-Saadi'},
    {'id': 4, 'name_ar': 'تفسير ابن كثير', 'name_en': 'Tafsir Ibn Kathir'},
    {
      'id': 5,
      'name_ar': 'تفسير الوسيط لطنطاوي',
      'name_en': 'Tafsir Al-Waseet by Tantawi',
    },
    {'id': 6, 'name_ar': 'تفسير البغوي', 'name_en': 'Tafsir Al-Baghawi'},
    {'id': 7, 'name_ar': 'تفسير القرطبي', 'name_en': 'Tafsir Al-Qurtubi'},
    {'id': 8, 'name_ar': 'تفسير الطبري', 'name_en': 'Tafsir At-Tabari'},
  ];

  List<InlineSpan> _buildSpans(BuildContext context, bool isArabic) {
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
      final endSymbol = quran.getVerseEndSymbol(ayah, arabicNumeral: isArabic);
      final text = isArabic
          ? quran.getVerse(widget.surahNumber, ayah)
          : quran.getVerseTranslation(widget.surahNumber, ayah);

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
          items: [
            PopupMenuItem(
              value: 'play',
              child: Text(widget.localizations.playVerseSound),
            ),
            PopupMenuItem(
              value: 'bookmark',
              child: Text(widget.localizations.bookmarkVerse),
            ),
            PopupMenuItem(
              value: 'tafseer',
              child: Text(widget.localizations.tafsirVerse),
            ),
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
                content: Text(
                  '${widget.localizations.bookmarkVerseSuccess} ${widget.isArabic ? convertToArabicNumbers(ayah.toString()) : ayah}',
                ),
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
              title: Text(
                widget.localizations.selectTafsir,
                textAlign: TextAlign.center,
              ),
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
                    final tafsirName = widget.isArabic
                        ? tafsir['name_ar']
                        : tafsir['name_en'];

                    return InkWell(
                      onTap: () => Navigator.pop(context, tafsir),
                      borderRadius: BorderRadius.circular(12),
                      child: Center(
                        child: Text(
                          tafsirName,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );

          if (selectedTafsir == null) return;

          if (mounted) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(child: CircularProgressIndicator()),
            );
          }
          final tafsirText = await fetchTafsirById(
            selectedTafsir['id'],
            widget.surahNumber,
            ayah,
          );
          final selectedTafsirName = widget.isArabic
              ? selectedTafsir['name_ar']
              : selectedTafsir['name_en'];
          final surahName = widget.isArabic
              ? quran.getSurahNameArabic(widget.surahNumber)
              : quran.getSurahName(widget.surahNumber);

          if (mounted) Navigator.pop(context);

          if (mounted) {
            showCustomModalBottomSheet(
              context: context,
              isScrollControlled: true,
              minChildSize: 0.3,
              initialChildSize: 0.7,
              maxChildSize: 0.9,
              builder: (context) => SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      '$selectedTafsirName - ${widget.isArabic ? 'للآية رقم ${convertToArabicNumbers(ayah.toString())} - سورة $surahName' : 'Verse Number $ayah - Surah $surahName'}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        tafsirText ?? widget.localizations.emptyTafsir,
                        textAlign: TextAlign.justify,
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(height: 1.7),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25.0,
                        vertical: 15,
                      ),
                      child: SizedBox(
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () {
                            SharePlus.instance.share(
                              ShareParams(
                                text:
                                    '''
📖 $selectedTafsirName
${widget.isArabic ? 'سورة $surahName - الآية رقم ${convertToArabicNumbers(ayah.toString())}' : 'Surah $surahName - Verse Number $ayah'}

────────────────────
${widget.isArabic ? quran.getVerse(widget.surahNumber, ayah) : quran.getVerseTranslation(widget.surahNumber, ayah)}
────────────────────

💬 التفسير:
$tafsirText

────────────────────
🔗 ${widget.isArabic ? 'تم مشاركته من تطبيق مسلم ' : 'Shared from Muslim App'}
    ''',
                              ),
                            );
                          },
                          child: Text(widget.localizations.shareTafsir),
                        ),
                      ),
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
              height: widget.isArabic ? 2.3 : 1.7,
              fontWeight: FontWeight.normal,
            ),
            children: _buildSpans(context, widget.isArabic),
          ),
        ),
      ),
    ),
  );
}

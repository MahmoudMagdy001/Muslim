// widgets/surah_text_view_horizontal.dart
import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/quran.dart' as quran;

import '../../../../core/utils/custom_modal_sheet.dart';
import '../../../../core/utils/format_helper.dart';
import '../../../../l10n/app_localizations.dart';
import '../../repository/tafsir_repository.dart';
import '../../viewmodel/quran_player_cubit/quran_player_cubit.dart';
import '../../viewmodel/bookmarks_cubit/bookmarks_cubit.dart';
import 'create_share_tafsir.dart';
import 'verse_options_menu.dart';

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
  final TafsirRepository _tafsirRepository = TafsirRepository();
  GlobalKey? _currentKey;
  int? _currentAyah;
  StreamSubscription? _playerSub;
  final Map<int, GlobalKey> _ayahKeys = {};
  List<InlineSpan>? _cachedSpans;
  int? _cachedSurahNumber;
  int? _cachedCurrentAyah;

  @override
  void initState() {
    super.initState();
    _generateKeys();
  }

  @override
  void didUpdateWidget(SurahTextView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.surahNumber != widget.surahNumber) {
      _generateKeys();
      _cachedSpans = null;
    }
  }

  void _generateKeys() {
    _ayahKeys.clear();
    final ayahCount = quran.getVerseCount(widget.surahNumber);
    for (int i = 1; i <= ayahCount; i++) {
      _ayahKeys[i] = GlobalKey();
    }
  }

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

  List<InlineSpan> _buildSpans(BuildContext context, bool isArabic) {
    final adjustedAyah = _currentAyah;

    if (_cachedSpans != null &&
        _cachedSurahNumber == widget.surahNumber &&
        _cachedCurrentAyah == adjustedAyah) {
      return _cachedSpans!;
    }

    final ayahCount = quran.getVerseCount(widget.surahNumber);
    final spans = <InlineSpan>[];
    _currentKey = adjustedAyah != null ? _ayahKeys[adjustedAyah] : null;

    for (int ayah = 1; ayah <= ayahCount; ayah++) {
      final endSymbol = quran.getVerseEndSymbol(ayah, arabicNumeral: isArabic);
      final text = isArabic
          ? quran.getVerse(widget.surahNumber, ayah)
          : quran.getVerseTranslation(widget.surahNumber, ayah);

      final isCurrent = ayah == adjustedAyah;
      final keyForThisAyah = _ayahKeys[ayah];

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
        final position = tapPosition ?? Offset.zero;

        final selected = await VerseOptionsMenu.show(
          context,
          position: position,
          localizations: widget.localizations,
        );

        if (selected == 'play') {
          _handlePlay(ayah);
        } else if (selected == 'bookmark') {
          _handleBookmark(ayah, text);
        } else if (selected == 'tafseer') {
          await _handleTafsir(ayah, text);
        }
      };

    return tapRecognizer;
  }

  void _handlePlay(int ayah) {
    if (mounted) {
      context.read<QuranPlayerCubit>().seek(Duration.zero, index: ayah - 1);
      context.read<QuranPlayerCubit>().play();
    }
  }

  void _handleBookmark(int ayah, String text) {
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
  }

  Future<void> _handleTafsir(int ayah, String text) async {
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
            itemCount: TafsirRepository.tafasirList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
              childAspectRatio: 1.9,
            ),
            itemBuilder: (context, index) {
              final tafsir = TafsirRepository.tafasirList[index];
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
    final tafsirText = await _tafsirRepository.fetchTafsirById(
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
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
                    onPressed: () async {
                      await createAndShareTafsirImage(
                        surahName: surahName,
                        ayahNumber: ayah,
                        ayahText: text,
                        tafsirTitle: selectedTafsirName,
                        tafsirText: tafsirText ?? '',
                        isArabic: widget.isArabic,
                        context: context,
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

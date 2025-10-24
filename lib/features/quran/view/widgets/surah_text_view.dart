import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/quran.dart' as quran;

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _playerSub ??= context.read<QuranPlayerCubit>().stream.listen((
      playerState,
    ) {
      final newAyah = playerState.currentAyah;
      if (!mounted) return;
      if (newAyah != null && newAyah != _currentAyah) {
        setState(() {
          _currentAyah = newAyah;
        });
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
            TextSpan(text: endSymbol, style: GoogleFonts.amiri().copyWith()),
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
          ],
        );

        if (selected == 'play') {
          if (mounted) {
            context.read<QuranPlayerCubit>().seek(Duration.zero, index: ayah);
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
  Widget build(BuildContext context) => Expanded(
    child: Scrollbar(
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
    ),
  );
}

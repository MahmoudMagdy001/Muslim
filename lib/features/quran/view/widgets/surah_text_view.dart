import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quran/quran.dart' as quran;

import '../../viewmodel/quran_player_cubit/quran_player_cubit.dart';
import '../../viewmodel/bookmarks_cubit/bookmarks_cubit.dart';

class SurahTextView extends StatefulWidget {
  const SurahTextView({required this.surahNumber, super.key});

  final int surahNumber;

  @override
  State<SurahTextView> createState() => _SurahTextViewState();
}

class _SurahTextViewState extends State<SurahTextView> {
  final ScrollController _controller = ScrollController();
  GlobalKey? _currentKey;
  int? _currentAyah;
  StreamSubscription? _playerSub;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _playerSub ??= context.read<QuranPlayerCubit>().stream.listen((
      playerState,
    ) {
      if (!playerState.isPlaying) return;

      final newAyah = playerState.currentAyah;
      if (!mounted) return;
      if (newAyah != _currentAyah) {
        setState(() {
          _currentAyah = newAyah;
        });
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToCurrentAyah();
        });
      }
    });
  }

  @override
  void dispose() {
    _playerSub?.cancel();
    _controller.dispose();
    super.dispose();
  }

  List<InlineSpan> _buildSpans(BuildContext context) {
    final ayahCount = quran.getVerseCount(widget.surahNumber);
    final spans = <InlineSpan>[];
    _currentKey = null;

    for (int ayah = 1; ayah <= ayahCount; ayah++) {
      final text = quran.getVerse(
        widget.surahNumber,
        ayah,
        verseEndSymbol: true,
      );
      final isCurrent = ayah == _currentAyah;
      final keyForThisAyah = isCurrent ? (_currentKey = GlobalKey()) : null;

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
              recognizer: () {
                final tapRecognizer = TapGestureRecognizer();
                Offset? tapPosition;
                tapRecognizer
                  ..onTapDown = (details) {
                    tapPosition = details.globalPosition;
                  }
                  ..onTap = () async {
                    final overlay =
                        Overlay.of(context).context.findRenderObject()
                            as RenderBox;
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
                        const PopupMenuItem(
                          value: 'play',
                          child: Text('تشغيل من هذه الآية'),
                        ),
                        const PopupMenuItem(
                          value: 'bookmark',
                          child: Text('حفظ علامة على هذه الآية'),
                        ),
                      ],
                    );

                    if (selected == 'play') {
                      if (context.mounted) {
                        context.read<QuranPlayerCubit>().seek(
                          Duration.zero,
                          index: ayah - 1,
                        );
                        context.read<QuranPlayerCubit>().play();
                      }
                    } else if (selected == 'bookmark') {
                      if (context.mounted) {
                        context.read<BookmarksCubit>().addBookmark(
                          surah: widget.surahNumber,
                          ayah: ayah,
                          ayahText: text,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'تم حفظ علامه علي اية : $text رقم :$ayah',
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }
                    }
                  };
                return tapRecognizer;
              }(),
            ),
          ],
        ),
      );
    }
    return spans;
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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

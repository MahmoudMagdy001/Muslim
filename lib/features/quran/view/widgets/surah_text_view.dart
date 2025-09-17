import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quran/quran.dart' as quran;

import '../../../../core/theme/app_colors.dart';
import '../../viewmodel/quran_player_cubit/quran_player_cubit.dart';

class SurahTextView extends StatefulWidget {
  const SurahTextView({required this.surahNumber, super.key});

  final int surahNumber;

  @override
  State<SurahTextView> createState() => _SurahTextViewState();
}

class _SurahTextViewState extends State<SurahTextView> {
  final ScrollController _controller = ScrollController();
  GlobalKey? _currentKey;
  late int _ayahCount;
  late List<InlineSpan> _spans;
  int? _currentAyah;
  StreamSubscription? _playerSub;

  @override
  void initState() {
    super.initState();
    _ayahCount = quran.getVerseCount(widget.surahNumber);
    _buildSpans();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _playerSub ??= context.read<QuranPlayerCubit>().stream.listen((
      playerState,
    ) {
      final newAyah = playerState.currentAyah;
      if (!mounted) return;
      if (newAyah != _currentAyah) {
        setState(() {
          _currentAyah = newAyah;
          _buildSpans();
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

  void _buildSpans() {
    _spans = <InlineSpan>[];
    _currentKey = null;

    for (int ayah = 1; ayah <= _ayahCount; ayah++) {
      final text = quran.getVerse(
        widget.surahNumber,
        ayah,
        verseEndSymbol: true,
      );
      final isCurrent = ayah == _currentAyah;

      final keyForThisAyah = isCurrent ? (_currentKey = GlobalKey()) : null;

      _spans.add(
        TextSpan(
          children: [
            WidgetSpan(
              alignment: PlaceholderAlignment.top,
              child: SizedBox(key: keyForThisAyah, width: 0, height: 0),
            ),
            TextSpan(
              text: '$text ',
              style: GoogleFonts.amiri().copyWith(
                color: isCurrent ? AppColors.primary : AppColors.black87,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  context.read<QuranPlayerCubit>().seek(
                    Duration.zero,
                    index: ayah - 1,
                  );
                  context.read<QuranPlayerCubit>().play();
                },
            ),
          ],
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: RepaintBoundary(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              height: 2.3,
              fontWeight: FontWeight.normal,
            ),
            children: _spans,
          ),
        ),
      ),
    ),
  );
}

// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

class VerseOptionsMenu {
  static Future<String?> show(
    BuildContext context, {
    required Offset position,
    required AppLocalizations localizations,
  }) async {
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final menuPosition = RelativeRect.fromLTRB(
      position.dx,
      position.dy,
      overlay.size.width - position.dx,
      overlay.size.height - position.dy,
    );

    return showMenu<String>(
      context: context,
      position: menuPosition,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      items: [
        PopupMenuItem(
          value: 'play',
          child: Row(
            children: [
              const Icon(Icons.play_arrow_rounded),
              const SizedBox(width: 12),
              Text(localizations.playVerseSound),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'bookmark',
          child: Row(
            children: [
              const Icon(Icons.bookmark_border_rounded),
              const SizedBox(width: 12),
              Text(localizations.bookmarkVerse),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'tafseer',
          child: Row(
            children: [
              const Icon(Icons.menu_book_rounded),
              const SizedBox(width: 12),
              Text(localizations.tafsirVerse),
            ],
          ),
        ),
      ],
    );
  }
}

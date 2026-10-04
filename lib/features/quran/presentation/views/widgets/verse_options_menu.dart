import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/l10n/app_localizations.dart';

class VerseOptionsMenu {
  static Future<String?> show(
    BuildContext context, {
    required Offset position,
    required AppLocalizations localizations,
  }) async {
    final overlay = Overlay.of(context).context.findRenderObject()! as RenderBox;
    final menuPosition = RelativeRect.fromLTRB(
      position.dx,
      position.dy,
      overlay.size.width - position.dx,
      overlay.size.height - position.dy,
    );
    final colors = context.colors;

    return showMenu<String>(
      context: context,
      position: menuPosition,
      color: colors.surface,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.r),
        side: BorderSide(
          color: colors.border,
          width: 0.8,
        ),
      ),
      items: [
        PopupMenuItem(
          value: 'play',
          child: Row(
            children: [
              Icon(
                Icons.play_circle_outline_rounded,
                color: colors.secondary,
                size: 20.r,
              ),
              SizedBox(width: 12.w),
              Text(
                localizations.playVerseSound,
                style: context.typography.titleSmall.copyWith(
                  color: colors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'bookmark',
          child: Row(
            children: [
              Icon(
                Icons.bookmark_border_rounded,
                color: colors.secondary,
                size: 20.r,
              ),
              SizedBox(width: 12.w),
              Text(
                localizations.bookmarkVerse,
                style: context.typography.titleSmall.copyWith(
                  color: colors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'tafseer',
          child: Row(
            children: [
              Icon(
                Icons.menu_book_rounded,
                color: colors.secondary,
                size: 20.r,
              ),
              SizedBox(width: 12.w),
              Text(
                localizations.tafsirVerse,
                style: context.typography.titleSmall.copyWith(
                  color: colors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

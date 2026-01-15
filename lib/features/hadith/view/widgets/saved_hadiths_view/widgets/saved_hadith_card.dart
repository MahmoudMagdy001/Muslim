import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions.dart';
import '../../../../../../core/utils/responsive_helper.dart';
import '../../../../../../core/utils/format_helper.dart';
import '../../../../helper/hadith_helper.dart';

class SavedHadithCard extends StatefulWidget {
  const SavedHadithCard({
    required this.hadith,
    required this.onTap,
    required this.onDelete,
    super.key,
  });
  final Map<String, dynamic> hadith;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  State<SavedHadithCard> createState() => _SavedHadithCardState();
}

class _SavedHadithCardState extends State<SavedHadithCard> {
  final ValueNotifier<bool> isExpandedNotifier = ValueNotifier(false);

  @override
  void dispose() {
    isExpandedNotifier.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    isExpandedNotifier.value = !isExpandedNotifier.value;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'صحيح':
      case 'Sahih':
      case 'sahih':
        return Colors.green;
      case 'حسن':
      case 'Hasan':
      case 'hasan':
        return Colors.blue;
      case 'ضعيف':
      case 'Da`eef':
      case 'da`eef':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  bool _needsExpandButton(String text, BuildContext context) {
    final textSpan = TextSpan(
      text: text,
      style: context.textTheme.titleMedium?.copyWith(height: 2.1),
    );

    final textPainter =
        TextPainter(
          text: textSpan,
          maxLines: 4,
          textDirection: TextDirection.rtl,
        )..layout(
          maxWidth: context.screenWidth - 64.toW,
        ); // Adjusted for padding (16*2 + card margin)
    return textPainter.didExceedMaxLines;
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final chapterName = widget.hadith['chapterName'];
    final chapterNumber = convertToArabicNumbers(
      widget.hadith['chapterNumber'],
    );
    final chapterId = convertToArabicNumbers(widget.hadith['id']);
    final needsExpandButton = _needsExpandButton(
      widget.hadith['text'],
      context,
    );

    return Padding(
      padding: EdgeInsets.only(bottom: 2.toH),
      child: Card(
        // Color removed to use theme default
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(12.toR),
          child: Padding(
            padding: EdgeInsets.all(16.toR),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'الكتاب: ${bookSlugArabic[widget.hadith['bookSlug']]}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.toH),
                Text('الفصل: $chapterName - رقم : $chapterNumber'),
                Text('رقم الحديث: $chapterId'),
                SizedBox(height: 12.toH),
                ValueListenableBuilder<bool>(
                  valueListenable: isExpandedNotifier,
                  builder: (context, isExpanded, child) => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        widget.hadith['text'],
                        style: theme.textTheme.titleMedium?.copyWith(
                          height: 1.8,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: isExpanded ? null : 4,
                        overflow: isExpanded ? null : TextOverflow.ellipsis,
                      ),
                      if (needsExpandButton)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: _toggleExpansion,
                            child: Text(isExpanded ? 'عرض أقل' : 'عرض المزيد'),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 8.toH),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'الحكم: ${widget.hadith['status']}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: _getStatusColor(widget.hadith['status']),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

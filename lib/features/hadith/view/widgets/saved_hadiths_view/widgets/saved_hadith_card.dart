import 'package:flutter/material.dart';
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
  bool _isExpanded = false;

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
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
      style: Theme.of(context).textTheme.titleMedium?.copyWith(height: 2.1),
    );

    final textPainter =
        TextPainter(
          text: textSpan,
          maxLines: 4,
          textDirection: TextDirection.rtl,
        )..layout(
          maxWidth: MediaQuery.of(context).size.width - 64,
        ); // Adjusted for padding (16*2 + card margin)
    return textPainter.didExceedMaxLines;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
      padding: const EdgeInsets.only(bottom: 2),
      child: Card(
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
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
                const SizedBox(height: 8),
                Text('الفصل: $chapterName - رقم : $chapterNumber'),
                Text('رقم الحديث: $chapterId'),
                const SizedBox(height: 12),
                Text(
                  widget.hadith['text'],
                  style: theme.textTheme.titleMedium?.copyWith(height: 2.1),
                  maxLines: _isExpanded ? null : 4,
                  overflow: _isExpanded ? null : TextOverflow.ellipsis,
                ),
                if (needsExpandButton)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: _toggleExpansion,
                      child: Text(_isExpanded ? 'عرض أقل' : 'عرض المزيد'),
                    ),
                  ),
                const SizedBox(height: 8),
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
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: widget.onDelete,
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

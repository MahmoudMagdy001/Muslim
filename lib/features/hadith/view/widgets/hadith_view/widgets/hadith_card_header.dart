import 'package:flutter/material.dart';

import '../../../../view_model/hadith/hadith_cubit.dart';

class HadithCardHeader extends StatelessWidget {
  const HadithCardHeader({
    required this.heading,
    required this.hadithId,
    required this.cubit,
    required this.onBookmarkPressed,
    super.key,
  });

  final String heading;
  final String hadithId;
  final HadithCubit cubit;
  final VoidCallback onBookmarkPressed;

  @override
  Widget build(BuildContext context) {
    final notifier = cubit.getHadithNotifier(hadithId) ?? ValueNotifier(false);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            heading,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ValueListenableBuilder<bool>(
          valueListenable: notifier,
          builder: (context, isSaved, _) => IconButton(
            icon: Icon(
              isSaved ? Icons.bookmark : Icons.bookmark_border,
              color: isSaved ? Colors.amber : Colors.grey,
              size: 28,
            ),
            onPressed: onBookmarkPressed,
          ),
        ),
      ],
    );
  }
}

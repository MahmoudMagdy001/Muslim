import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/features/hadith/presentation/bloc/hadith_bloc.dart';

class HadithCardHeader extends StatelessWidget {
  const HadithCardHeader({
    required this.heading,
    required this.hadithId,
    required this.bloc,
    required this.onBookmarkPressed,
    super.key,
  });

  final String heading;
  final String hadithId;
  final HadithBloc bloc;
  final VoidCallback onBookmarkPressed;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Text(
          heading,
          style: context.typography.titleMedium.copyWith(
            color: context.colors.textSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      BlocSelector<HadithBloc, HadithState, bool>(
        bloc: bloc,
        selector: (state) => state.savedHadithIds.contains(hadithId),
        builder: (context, isSaved) => IconButton(
          icon: Icon(
            isSaved ? Icons.bookmark : Icons.bookmark_border,
            color: isSaved ? Colors.amber : context.colors.textSecondary,
            size: 28,
          ),
          onPressed: onBookmarkPressed,
        ),
      ),
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim/core/widgets/custom_modal_sheet.dart';
import 'package:muslim/features/settings/data/constants/reciters_name_arabic.dart';
import 'package:muslim/features/settings/presentation/bloc/reciter/reciter_bloc.dart';
import 'package:muslim/features/settings/presentation/views/widgets/reciter_dialog.dart';
import 'package:muslim/l10n/app_localizations.dart';

class ReciterSection extends StatelessWidget {
  const ReciterSection({required this.localizations, required this.theme, super.key});

  final AppLocalizations localizations;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) => BlocBuilder<ReciterBloc, ReciterState>(
    builder: (context, state) {
      final reciterName = getReciterName(state.selectedReciter, context: context);
      final bloc = context.read<ReciterBloc>();

      return ListTile(
        leading: const Icon(Icons.headphones),
        title: Text(reciterName, style: theme.textTheme.titleMedium),
        trailing: const Icon(Icons.arrow_drop_down_rounded),
        onTap: () async {
          final currentReciter = bloc.state.selectedReciter;

          final result = await showCustomModalBottomSheet<String>(
            context: context,
            minChildSize: 0.3,
            initialChildSize: 0.6,
            isScrollControlled: true,
            builder: (context) => ReciterDialog(selectedReciterId: currentReciter, localizations: localizations),
          );

          if (result != null && result != currentReciter) {
            if (!context.mounted) return;
            final changedReciterName = getReciterName(result, context: context);
            await bloc.saveReciter(result);

            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${localizations.changeReciterSuccess}$changedReciterName'),
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          }
        },
      );
    },
  );
}

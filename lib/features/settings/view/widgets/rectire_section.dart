import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/custom_modal_sheet.dart';
import '../../../../l10n/app_localizations.dart';
import '../../consts/reciters_name_arabic.dart';
import '../../view_model/rectire/rectire_cubit.dart';
import 'rectire_dialog.dart'; // هنستخدمه جوة الـ bottom sheet

class ReciterSection extends StatelessWidget {
  const ReciterSection({
    required this.localizations,
    required this.isArabic,
    required this.theme,
    super.key,
  });

  final AppLocalizations localizations;
  final bool isArabic;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) => BlocBuilder<ReciterCubit, ReciterState>(
    builder: (context, state) {
      final reciterName = getReciterName(
        state.selectedReciter,
        isArabic: isArabic,
      );
      final cubit = context.read<ReciterCubit>();

      return ListTile(
        leading: const Icon(Icons.headphones),
        title: Text(reciterName, style: theme.textTheme.titleMedium),
        trailing: const Icon(Icons.arrow_drop_down_rounded),
        onTap: () async {
          final currentReciter = cubit.state.selectedReciter;

          final result = await showCustomModalBottomSheet<String>(
            context: context,
            minChildSize: 0.3,
            initialChildSize: 0.6,
            isScrollControlled: true,
            builder: (context) => ReciterDialog(
              selectedReciterId: currentReciter,
              localizations: localizations,
              isArabic: isArabic,
            ),
          );

          if (result != null && result != currentReciter) {
            await cubit.saveReciter(result);
            final changedReciterName = getReciterName(
              result,
              isArabic: isArabic,
            );

            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '${localizations.changeReciterSuccess}$changedReciterName',
                  ),
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

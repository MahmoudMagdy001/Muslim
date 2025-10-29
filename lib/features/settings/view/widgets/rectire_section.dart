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
    super.key,
  });
  final AppLocalizations localizations;
  final bool isArabic;

  @override
  Widget build(BuildContext context) => BlocBuilder<ReciterCubit, ReciterState>(
    builder: (context, state) {
      final reciterName = getReciterName(state.selectedReciter);
      return _ReciterTile(
        reciterName: reciterName,
        localizations: localizations,
        isArabic: isArabic,
      );
    },
  );
}

class _ReciterTile extends StatelessWidget {
  const _ReciterTile({
    required this.reciterName,
    required this.localizations,
    required this.isArabic,
  });
  final Map<String, String> reciterName;
  final AppLocalizations localizations;
  final bool isArabic;

  @override
  Widget build(BuildContext context) => ListTile(
    leading: const Icon(Icons.headphones, size: 20),
    title: Text(
      isArabic ? reciterName['ar']! : reciterName['en']!,
      style: Theme.of(context).textTheme.titleMedium,
    ),
    trailing: const Icon(Icons.arrow_drop_down_rounded, size: 26),
    onTap: () => _showReciterBottomSheet(context),
  );

  Future<void> _showReciterBottomSheet(BuildContext context) async {
    final cubit = context.read<ReciterCubit>();
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
      final changedReciterName = getReciterName(result);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${localizations.changeReciterSuccess}${isArabic ? changedReciterName['ar'] : changedReciterName['en']}',
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }
}

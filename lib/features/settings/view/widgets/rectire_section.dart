import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../consts/reciters_name_arabic.dart';
import '../../view_model/rectire/rectire_cubit.dart';
import 'rectire_dialog.dart';
import 'section_card.dart';

class ReciterSection extends StatelessWidget {
  const ReciterSection({super.key});

  @override
  Widget build(BuildContext context) => SectionCard(
    title: 'اختيار القارئ',
    child: BlocBuilder<ReciterCubit, ReciterState>(
      builder: (context, state) {
        final reciterName = getReciterName(state.selectedReciterId);
        return _ReciterTile(reciterName: reciterName);
      },
    ),
  );
}

class _ReciterTile extends StatelessWidget {
  const _ReciterTile({required this.reciterName});
  final String reciterName;

  @override
  Widget build(BuildContext context) => ListTile(
    leading: const Icon(Icons.headphones, size: 20),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(reciterName, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Text(
          'تغيير قارئ القرآن الكريم',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    ),
    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    onTap: () => _showReciterDialog(context),
  );

  Future<void> _showReciterDialog(BuildContext context) async {
    final cubit = context.read<ReciterCubit>();
    final currentReciter = cubit.state.selectedReciterId;

    final result = await showDialog<String>(
      context: context,
      builder: (context) => ReciterDialog(selectedReciterId: currentReciter),
    );

    if (result != null && result != currentReciter) {
      await cubit.saveReciter(result);

      // إظهار SnackBar بعد تغيير القارئ بنجاح
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('تم تغيير القارئ إلى ${getReciterName(result)}'),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}

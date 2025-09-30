import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../consts/reciters_name_arabic.dart';
import '../../view_model/rectire/rectire_cubit.dart';
import 'rectire_dialog.dart'; // هنستخدمه جوة الـ bottom sheet

class ReciterSection extends StatelessWidget {
  const ReciterSection({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<ReciterCubit, ReciterState>(
    builder: (context, state) {
      final reciterName = getReciterName(state.selectedReciter);
      return _ReciterTile(reciterName: reciterName);
    },
  );
}

class _ReciterTile extends StatelessWidget {
  const _ReciterTile({required this.reciterName});
  final String reciterName;

  @override
  Widget build(BuildContext context) => ListTile(
    leading: const Icon(Icons.headphones, size: 20),
    title: Text(reciterName, style: Theme.of(context).textTheme.titleMedium),
    trailing: const Icon(Icons.arrow_drop_down_rounded, size: 26),
    onTap: () => _showReciterBottomSheet(context),
  );

  Future<void> _showReciterBottomSheet(BuildContext context) async {
    final cubit = context.read<ReciterCubit>();
    final currentReciter = cubit.state.selectedReciter;

    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => DraggableScrollableSheet(
        minChildSize: 0.3,
        initialChildSize: 0.6,
        expand: false,
        builder: (context, scrollController) => Directionality(
          textDirection: TextDirection.rtl,
          child: ReciterDialog(selectedReciterId: currentReciter),
        ),
      ),
    );

    if (result != null && result != currentReciter) {
      await cubit.saveReciter(result);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('تم تغيير القارئ إلى ${getReciterName(result)}'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }
}

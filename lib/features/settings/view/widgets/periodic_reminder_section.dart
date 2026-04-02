import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/service/periodic_reminder_constants.dart';
import '../../../../core/service/permissions_sevice.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/custom_modal_sheet.dart';
import '../../../../l10n/app_localizations.dart';
import '../../view_model/periodic_reminder/periodic_reminder_cubit.dart';

/// Settings section widget for managing periodic Islamic reminders.
class PeriodicReminderSection extends StatelessWidget {
  const PeriodicReminderSection({
    required this.theme,
    required this.isArabic,
    super.key,
  });

  final ThemeData theme;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return BlocBuilder<PeriodicReminderCubit, PeriodicReminderState>(
      builder: (context, state) => ListTile(
        leading: const Icon(Icons.timer_rounded),
        title: Text(
          isArabic ? 'التذكير الدوري' : 'Periodic Reminder',
          style: theme.textTheme.titleMedium,
        ),
        subtitle: state.enabled
            ? Text(
                isArabic
                    ? 'كل ${state.intervalMinutes} دقيقة'
                    : 'Every ${state.intervalMinutes} minutes',
                style: theme.textTheme.bodySmall,
              )
            : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Switch(
              value: state.enabled,
              onChanged: (value) => _handleToggle(context, value),
            ),
            const Icon(Icons.arrow_drop_down_rounded),
          ],
        ),
        onTap: () => _showIntervalModal(context, localizations, state),
      ),
    );
  }

  Future<void> _handleToggle(BuildContext context, bool value) async {
    if (value) {
      // Request permissions before enabling
      await requestAllPermissions();
    }
    if (context.mounted) {
      context.read<PeriodicReminderCubit>().toggleEnabled(value);
    }
  }

  void _showIntervalModal(
    BuildContext context,
    AppLocalizations localizations,
    PeriodicReminderState state,
  ) {
    showCustomModalBottomSheet(
      context: context,
      builder: (context) => _IntervalSelectionModal(
        theme: theme,
        isArabic: isArabic,
        currentInterval: state.intervalMinutes,
        onIntervalSelected: (minutes) {
          context.read<PeriodicReminderCubit>().setInterval(minutes);
          Navigator.of(context).pop();
        },
      ),
    );
  }
}

class _IntervalSelectionModal extends StatelessWidget {
  const _IntervalSelectionModal({
    required this.theme,
    required this.isArabic,
    required this.currentInterval,
    required this.onIntervalSelected,
  });

  final ThemeData theme;
  final bool isArabic;
  final int currentInterval;
  final ValueChanged<int> onIntervalSelected;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Padding(
        padding: EdgeInsets.all(16.toR),
        child: Text(
          isArabic ? 'اختر الفاصل الزمني' : 'Select Time Interval',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      ...PeriodicReminderConstants.availableIntervals.map(
        (minutes) => _IntervalOption(
          minutes: minutes,
          isSelected: minutes == currentInterval,
          isArabic: isArabic,
          theme: theme,
          onTap: () => onIntervalSelected(minutes),
        ),
      ),
      SizedBox(height: 16.toH),
    ],
  );
}

class _IntervalOption extends StatelessWidget {
  const _IntervalOption({
    required this.minutes,
    required this.isSelected,
    required this.isArabic,
    required this.theme,
    required this.onTap,
  });

  final int minutes;
  final bool isSelected;
  final bool isArabic;
  final ThemeData theme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final label = isArabic ? '$minutes دقيقة' : '$minutes minutes';

    return ListTile(
      leading: Icon(
        isSelected ? Icons.check_circle_rounded : Icons.circle_outlined,
        color: isSelected ? theme.colorScheme.primary : theme.iconTheme.color,
      ),
      title: Text(label, style: theme.textTheme.bodyLarge),
      onTap: onTap,
      selected: isSelected,
      selectedTileColor: theme.colorScheme.primary.withValues(alpha: 0.1),
    );
  }
}

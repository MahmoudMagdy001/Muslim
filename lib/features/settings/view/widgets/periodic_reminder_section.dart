import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim/core/di/service_locator.dart';
import 'package:muslim/core/service/periodic_reminder_constants.dart';
import 'package:muslim/core/service/permissions_sevice.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/responsive_helper.dart';
import 'package:muslim/core/widgets/custom_modal_sheet.dart';
import 'package:muslim/features/settings/view_model/periodic_reminder/periodic_reminder_cubit.dart';

/// Settings section widget for managing periodic Islamic reminders.
class PeriodicReminderSection extends StatelessWidget {
  const PeriodicReminderSection({
    required this.theme,
    super.key,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocProvider(
      create: (_) => getIt<PeriodicReminderCubit>(),
      child: Builder(
        builder: (context) => BlocBuilder<PeriodicReminderCubit, PeriodicReminderState>(
          builder: (context, state) => ListTile(
            leading: const Icon(Icons.timer_rounded),
            title: Text(
              l10n.periodicReminderTitle,
              style: theme.textTheme.titleMedium,
            ),
            subtitle: state.enabled
                ? Text(
                    l10n.everyNMinutes(state.intervalMinutes),
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
            onTap: () => _showIntervalModal(context, state),
          ),
        ),
      ),
    );
  }

  Future<void> _handleToggle(BuildContext context, bool value) async {
    if (value) {
      await requestAllPermissions();
    }
    if (context.mounted) {
      await context.read<PeriodicReminderCubit>().toggleEnabled(enabled: value);
    }
  }

  void _showIntervalModal(
    BuildContext context,
    PeriodicReminderState state,
  ) {
    final cubit = context.read<PeriodicReminderCubit>();
    unawaited(
      showCustomModalBottomSheet<void>(
        context: context,
        builder: (modalContext) => _IntervalSelectionModal(
          theme: theme,
          currentInterval: state.intervalMinutes,
          onIntervalSelected: (minutes) async {
            await cubit.setInterval(minutes);
            if (modalContext.mounted) {
              Navigator.of(modalContext).pop();
            }
          },
        ),
      ),
    );
  }
}

class _IntervalSelectionModal extends StatelessWidget {
  const _IntervalSelectionModal({
    required this.theme,
    required this.currentInterval,
    required this.onIntervalSelected,
  });

  final ThemeData theme;
  final int currentInterval;
  final ValueChanged<int> onIntervalSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.all(16.toR),
          child: Text(
            l10n.selectTimeInterval,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...PeriodicReminderConstants.availableIntervals.map(
          (minutes) => _IntervalOption(
            minutes: minutes,
            isSelected: minutes == currentInterval,
            theme: theme,
            onTap: () => onIntervalSelected(minutes),
          ),
        ),
        SizedBox(height: 16.toH),
      ],
    );
  }
}

class _IntervalOption extends StatelessWidget {
  const _IntervalOption({
    required this.minutes,
    required this.isSelected,
    required this.theme,
    required this.onTap,
  });

  final int minutes;
  final bool isSelected;
  final ThemeData theme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return ListTile(
      leading: Icon(
        isSelected ? Icons.check_circle_rounded : Icons.circle_outlined,
        color: isSelected ? theme.colorScheme.primary : theme.iconTheme.color,
      ),
      title: Text(l10n.nMinutes(minutes), style: theme.textTheme.bodyLarge),
      onTap: onTap,
      selected: isSelected,
      selectedTileColor: theme.colorScheme.primary.withValues(alpha: 0.1),
    );
  }
}

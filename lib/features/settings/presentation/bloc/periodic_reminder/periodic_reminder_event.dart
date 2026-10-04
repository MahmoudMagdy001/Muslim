import 'package:freezed_annotation/freezed_annotation.dart';

part 'periodic_reminder_event.freezed.dart';

@freezed
sealed class PeriodicReminderEvent with _$PeriodicReminderEvent {
  const factory PeriodicReminderEvent.loadSettings() = PeriodicReminderLoadSettings;
  const factory PeriodicReminderEvent.toggleEnabled({required bool enabled}) = PeriodicReminderToggleEnabled;
  const factory PeriodicReminderEvent.setInterval(int minutes) = PeriodicReminderSetInterval;
  const factory PeriodicReminderEvent.rescheduleIfEnabled() = PeriodicReminderRescheduleIfEnabled;
  const factory PeriodicReminderEvent.cancelAndReset() = PeriodicReminderCancelAndReset;
  const factory PeriodicReminderEvent.refresh() = PeriodicReminderRefresh;
}

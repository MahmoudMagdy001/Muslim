import 'package:freezed_annotation/freezed_annotation.dart';

part 'last_played_event.freezed.dart';

@freezed
sealed class LastPlayedEvent with _$LastPlayedEvent {
  const factory LastPlayedEvent.initialize() = LastPlayedInitialize;
  const factory LastPlayedEvent.dataReceived(Map<String, dynamic>? data) = LastPlayedDataReceived;
}

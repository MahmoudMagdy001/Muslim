import 'package:freezed_annotation/freezed_annotation.dart';

part 'azkar_event.freezed.dart';

@freezed
sealed class AzkarEvent with _$AzkarEvent {
  const factory AzkarEvent.loadAzkar() = AzkarLoadAzkar;
  const factory AzkarEvent.loadAzkarContent(String url) = AzkarLoadAzkarContent;
  const factory AzkarEvent.decrementCount(String url, int index) = AzkarDecrementCount;
  const factory AzkarEvent.resetCount(String url, int index) = AzkarResetCount;
}

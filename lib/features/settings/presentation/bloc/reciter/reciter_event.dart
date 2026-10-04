import 'package:freezed_annotation/freezed_annotation.dart';

part 'reciter_event.freezed.dart';

@freezed
sealed class ReciterEvent with _$ReciterEvent {
  const factory ReciterEvent.initialize() = ReciterInitialize;
  const factory ReciterEvent.saveReciter(String reciterId) = ReciterSaveReciter;
}

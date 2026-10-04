import 'package:freezed_annotation/freezed_annotation.dart';

part 'last_played_state.freezed.dart';

@freezed
abstract class LastPlayedState with _$LastPlayedState {
  const factory LastPlayedState({
    Map<String, dynamic>? lastPlayed,
  }) = _LastPlayedState;
}

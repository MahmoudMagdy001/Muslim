import 'package:equatable/equatable.dart';

class LastPlayedState extends Equatable {
  const LastPlayedState({this.lastPlayed});
  final Map<String, dynamic>? lastPlayed;

  @override
  List<Object?> get props => [lastPlayed];
}

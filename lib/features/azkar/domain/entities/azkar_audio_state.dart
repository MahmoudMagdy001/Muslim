import 'package:equatable/equatable.dart';

enum AzkarAudioStatus { initial, loading, playing, stopped }

class AzkarAudioState extends Equatable {
  const AzkarAudioState({required this.status, this.url});

  final AzkarAudioStatus status;
  final String? url;

  AzkarAudioState copyWith({AzkarAudioStatus? status, String? url}) =>
      AzkarAudioState(status: status ?? this.status, url: url ?? this.url);

  @override
  List<Object?> get props => [status, url];
}

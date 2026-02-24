import '../../domain/entities/azkar_audio_state.dart';

abstract class AzkarAudioDataSource {
  Stream<AzkarAudioState> get stateStream;
  AzkarAudioState get currentState;
  Future<void> play(String url, {String? title});
  Future<void> stop();
  void dispose();
}

import '../entities/azkar_audio_state.dart';
import '../repositories/azkar_repository.dart';

class GetCurrentAudioStateUseCase {
  GetCurrentAudioStateUseCase(this.repository);
  final AzkarRepository repository;

  AzkarAudioState call() => repository.currentAudioState;
}

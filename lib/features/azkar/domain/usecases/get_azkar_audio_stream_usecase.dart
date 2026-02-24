import '../entities/azkar_audio_state.dart';
import '../repositories/azkar_repository.dart';

class GetAzkarAudioStreamUseCase {
  GetAzkarAudioStreamUseCase(this.repository);
  final AzkarRepository repository;

  Stream<AzkarAudioState> call() => repository.getAudioStateStream();
}

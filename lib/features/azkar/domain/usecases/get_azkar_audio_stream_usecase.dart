import 'package:muslim/features/azkar/domain/entities/azkar_audio_state.dart';
import 'package:muslim/features/azkar/domain/repositories/azkar_repository.dart';

class GetAzkarAudioStreamUseCase {
  GetAzkarAudioStreamUseCase(this.repository);
  final AzkarRepository repository;

  Stream<AzkarAudioState> call() => repository.getAudioStateStream();
}

import 'package:muslim/features/azkar/domain/entities/azkar_audio_state.dart';
import 'package:muslim/features/azkar/domain/repositories/azkar_repository.dart';

class GetCurrentAudioStateUseCase {
  GetCurrentAudioStateUseCase(this.repository);
  final AzkarRepository repository;

  AzkarAudioState call() => repository.currentAudioState;
}

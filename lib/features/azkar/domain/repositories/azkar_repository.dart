import 'package:dartz/dartz.dart';

import 'package:muslim/core/error/failures.dart';
import 'package:muslim/features/azkar/domain/entities/azkar_audio_state.dart';
import 'package:muslim/features/azkar/domain/entities/azkar_entity.dart';

abstract class AzkarRepository {
  Future<Either<Failure, List<AzkarEntity>>> getAzkarList();
  Future<Either<Failure, List<AzkarContentEntity>>> getAzkarContent(String url);

  // Persistence
  Future<Either<Failure, void>> saveAzkarCount(
    String sourceUrl,
    int index,
    int count,
  );
  Future<Either<Failure, int?>> getAzkarCount(String sourceUrl, int index);
  Future<Either<Failure, void>> clearAzkarCountIfNewDay();

  // Audio
  Future<Either<Failure, void>> playAudio(String url, {String? title});
  Future<Either<Failure, void>> stopAudio();
  Stream<AzkarAudioState> getAudioStateStream();
  AzkarAudioState get currentAudioState;
}

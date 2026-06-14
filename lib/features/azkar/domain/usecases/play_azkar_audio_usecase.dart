import 'package:dartz/dartz.dart';

import 'package:muslim/core/error/failures.dart';
import 'package:muslim/core/usecases/usecase.dart';
import 'package:muslim/features/azkar/domain/repositories/azkar_repository.dart';

class PlayAzkarAudioUseCase implements UseCase<void, PlayAzkarAudioParams> {
  PlayAzkarAudioUseCase(this.repository);
  final AzkarRepository repository;

  @override
  Future<Either<Failure, void>> call(PlayAzkarAudioParams params) =>
      repository.playAudio(params.url, title: params.title);
}

class PlayAzkarAudioParams {
  const PlayAzkarAudioParams({required this.url, this.title});
  final String url;
  final String? title;
}

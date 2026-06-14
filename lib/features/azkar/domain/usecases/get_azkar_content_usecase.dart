import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:muslim/core/error/failures.dart';
import 'package:muslim/core/usecases/usecase.dart';
import 'package:muslim/features/azkar/domain/entities/azkar_entity.dart';
import 'package:muslim/features/azkar/domain/repositories/azkar_repository.dart';

class GetAzkarContentUseCase
    implements UseCase<List<AzkarContentEntity>, GetAzkarContentParams> {
  GetAzkarContentUseCase(this.repository);
  final AzkarRepository repository;

  @override
  Future<Either<Failure, List<AzkarContentEntity>>> call(
    GetAzkarContentParams params,
  ) async => repository.getAzkarContent(params.url);
}

class GetAzkarContentParams extends Equatable {
  const GetAzkarContentParams({required this.url});
  final String url;

  @override
  List<Object?> get props => [url];
}

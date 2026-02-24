import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/azkar_entity.dart';
import '../repositories/azkar_repository.dart';

class GetAzkarContentUseCase
    implements UseCase<List<AzkarContentEntity>, GetAzkarContentParams> {
  GetAzkarContentUseCase(this.repository);
  final AzkarRepository repository;

  @override
  Future<Either<Failure, List<AzkarContentEntity>>> call(
    GetAzkarContentParams params,
  ) async => await repository.getAzkarContent(params.url);
}

class GetAzkarContentParams extends Equatable {
  const GetAzkarContentParams({required this.url});
  final String url;

  @override
  List<Object?> get props => [url];
}

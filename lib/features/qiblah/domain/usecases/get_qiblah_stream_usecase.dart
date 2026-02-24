import '../entities/qiblah_direction_entity.dart';
import '../repositories/qiblah_repository.dart';

class GetQiblahStreamUseCase {
  const GetQiblahStreamUseCase(this.repository);

  final QiblahRepository repository;

  Stream<QiblahDirectionEntity> call() => repository.getQiblahStream();
}

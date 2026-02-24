import '../entities/qiblah_direction_entity.dart';

abstract class QiblahRepository {
  Stream<QiblahDirectionEntity> getQiblahStream();
}

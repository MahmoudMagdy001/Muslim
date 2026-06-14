import 'package:muslim/features/qiblah/domain/entities/qiblah_direction_entity.dart';

abstract class QiblahRepository {
  Stream<QiblahDirectionEntity> getQiblahStream();
}

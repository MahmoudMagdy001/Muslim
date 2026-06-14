import 'package:muslim/features/qiblah/data/datasources/qiblah_local_data_source.dart';
import 'package:muslim/features/qiblah/data/models/qiblah_direction_model.dart';
import 'package:muslim/features/qiblah/domain/entities/qiblah_direction_entity.dart';
import 'package:muslim/features/qiblah/domain/repositories/qiblah_repository.dart';

class QiblahRepositoryImpl implements QiblahRepository {
  const QiblahRepositoryImpl({required this.localDataSource});

  final QiblahLocalDataSource localDataSource;

  @override
  Stream<QiblahDirectionEntity> getQiblahStream() => localDataSource
      .qiblahStream
      .map(QiblahDirectionModel.fromFlutterQiblah);
}

import '../../domain/entities/qiblah_direction_entity.dart';
import '../../domain/repositories/qiblah_repository.dart';
import '../datasources/qiblah_local_data_source.dart';
import '../models/qiblah_direction_model.dart';

class QiblahRepositoryImpl implements QiblahRepository {
  const QiblahRepositoryImpl({required this.localDataSource});

  final QiblahLocalDataSource localDataSource;

  @override
  Stream<QiblahDirectionEntity> getQiblahStream() => localDataSource
      .qiblahStream
      .map((data) => QiblahDirectionModel.fromFlutterQiblah(data));
}

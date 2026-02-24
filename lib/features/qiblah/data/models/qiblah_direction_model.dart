import 'package:flutter_qiblah/flutter_qiblah.dart';

import '../../domain/entities/qiblah_direction_entity.dart';

class QiblahDirectionModel extends QiblahDirectionEntity {
  const QiblahDirectionModel({
    required super.qiblah,
    required super.direction,
    required super.offset,
  });

  factory QiblahDirectionModel.fromFlutterQiblah(QiblahDirection data) =>
      QiblahDirectionModel(
        qiblah: data.qiblah,
        direction: data.direction,
        offset: data.offset,
      );
}

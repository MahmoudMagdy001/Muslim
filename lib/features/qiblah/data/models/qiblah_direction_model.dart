import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:muslim/features/qiblah/domain/entities/qiblah_direction_entity.dart';

part 'qiblah_direction_model.freezed.dart';

@freezed
abstract class QiblahDirectionModel with _$QiblahDirectionModel {
  const QiblahDirectionModel._();

  const factory QiblahDirectionModel({
    required double qiblah,
    required double direction,
    required double offset,
  }) = _QiblahDirectionModel;

  factory QiblahDirectionModel.fromFlutterQiblah(QiblahDirection data) =>
      QiblahDirectionModel(
        qiblah: data.qiblah,
        direction: data.direction,
        offset: data.offset,
      );

  QiblahDirectionEntity toEntity() => QiblahDirectionEntity(
    qiblah: qiblah,
    direction: direction,
    offset: offset,
  );
}

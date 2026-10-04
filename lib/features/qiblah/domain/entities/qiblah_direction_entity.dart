import 'package:freezed_annotation/freezed_annotation.dart';

part 'qiblah_direction_entity.freezed.dart';

@freezed
abstract class QiblahDirectionEntity with _$QiblahDirectionEntity {
  const factory QiblahDirectionEntity({
    required double qiblah,
    required double direction,
    required double offset,
  }) = _QiblahDirectionEntity;
}

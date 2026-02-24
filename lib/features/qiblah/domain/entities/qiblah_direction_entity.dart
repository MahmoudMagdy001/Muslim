import 'package:equatable/equatable.dart';

class QiblahDirectionEntity extends Equatable {
  const QiblahDirectionEntity({
    required this.qiblah,
    required this.direction,
    required this.offset,
  });

  final double qiblah;
  final double direction;
  final double offset;

  @override
  List<Object?> get props => [qiblah, direction, offset];
}

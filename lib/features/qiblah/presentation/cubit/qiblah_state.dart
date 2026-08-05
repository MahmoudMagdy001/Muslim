// ponytail: simplified QiblahState by removing dead route/location fields & latlong2 dependency
import 'package:equatable/equatable.dart';

enum QiblahStatus { initial, loading, success, error }

class QiblahState extends Equatable {
  const QiblahState({
    this.status = QiblahStatus.initial,
    this.message,
    this.qiblahAngle = 0.0,
    this.headingAngle = 0.0,
    this.isAligned = false,
  });

  final QiblahStatus status;
  final String? message;
  final double qiblahAngle;
  final double headingAngle;
  final bool isAligned;

  QiblahState copyWith({
    QiblahStatus? status,
    String? message,
    double? qiblahAngle,
    double? headingAngle,
    bool? isAligned,
  }) => QiblahState(
    status: status ?? this.status,
    message: message ?? this.message,
    qiblahAngle: qiblahAngle ?? this.qiblahAngle,
    headingAngle: headingAngle ?? this.headingAngle,
    isAligned: isAligned ?? this.isAligned,
  );

  @override
  List<Object?> get props => [
    status,
    message,
    qiblahAngle,
    headingAngle,
    isAligned,
  ];
}

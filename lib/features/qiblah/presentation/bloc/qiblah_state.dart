import 'package:freezed_annotation/freezed_annotation.dart';

part 'qiblah_state.freezed.dart';

enum QiblahStatus { initial, loading, success, error }

@freezed
abstract class QiblahState with _$QiblahState {
  const factory QiblahState({
    @Default(QiblahStatus.initial) QiblahStatus status,
    @Default(0.0) double qiblahAngle,
    @Default(0.0) double headingAngle,
    @Default(false) bool isAligned,
    String? message,
  }) = _QiblahState;
}

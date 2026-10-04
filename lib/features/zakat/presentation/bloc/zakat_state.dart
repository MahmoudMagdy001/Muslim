import 'package:freezed_annotation/freezed_annotation.dart';

part 'zakat_state.freezed.dart';

enum ZakatRequestStatus { initial, loading, success, error }

@freezed
abstract class ZakatState with _$ZakatState {
  const ZakatState._();

  const factory ZakatState({
    @Default(ZakatRequestStatus.initial) ZakatRequestStatus status,
    @Default(0.0) double goldPricePerGram,
    String? errorMessage,
  }) = _ZakatState;

  double get nisabInEgp => goldPricePerGram * 85.0;
}

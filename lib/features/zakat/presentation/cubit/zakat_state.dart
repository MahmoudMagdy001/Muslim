import 'package:equatable/equatable.dart';

enum ZakatRequestStatus { initial, loading, success, error }

class ZakatState extends Equatable {
  const ZakatState({
    this.status = ZakatRequestStatus.initial,
    this.goldPricePerGram = 0.0,
    this.errorMessage,
  });
  final ZakatRequestStatus status;
  final double goldPricePerGram;
  final String? errorMessage;

  ZakatState copyWith({
    ZakatRequestStatus? status,
    double? goldPricePerGram,
    String? errorMessage,
  }) => ZakatState(
    status: status ?? this.status,
    goldPricePerGram: goldPricePerGram ?? this.goldPricePerGram,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  double get nisabInEgp => goldPricePerGram * 85.0;

  @override
  List<Object?> get props => [status, goldPricePerGram, errorMessage];
}

// ponytail: simple domain entity for Gold Price
import 'package:equatable/equatable.dart';

class GoldPriceEntity extends Equatable {
  const GoldPriceEntity({
    required this.priceInUsd,
    required this.currency,
  });

  final double priceInUsd;
  final String currency;

  @override
  List<Object?> get props => [priceInUsd, currency];
}

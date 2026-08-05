// ponytail: GoldPriceModel extending GoldPriceEntity with JSON serialization
import 'package:muslim/features/zakat/domain/entities/gold_price_entity.dart';

class GoldPriceModel extends GoldPriceEntity {
  const GoldPriceModel({required super.priceInUsd, required super.currency});

  factory GoldPriceModel.fromJson(Map<String, dynamic> json) => GoldPriceModel(
    priceInUsd: (json['price'] as num?)?.toDouble() ?? 0.0,
    currency: (json['currency'] as String?) ?? 'USD',
  );

  Map<String, dynamic> toJson() => {'price': priceInUsd, 'currency': currency};
}

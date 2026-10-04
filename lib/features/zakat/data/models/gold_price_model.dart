import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:muslim/features/zakat/domain/entities/gold_price_entity.dart';

part 'gold_price_model.freezed.dart';

@Freezed(toJson: false, fromJson: false)
abstract class GoldPriceModel with _$GoldPriceModel {
  const GoldPriceModel._();

  const factory GoldPriceModel({
    required double priceInUsd,
    required String currency,
  }) = _GoldPriceModel;

  factory GoldPriceModel.fromJson(Map<String, dynamic> json) => GoldPriceModel(
    priceInUsd: (json['price'] as num?)?.toDouble() ?? 0.0,
    currency: (json['currency'] as String?) ?? 'USD',
  );

  GoldPriceEntity toEntity() => GoldPriceEntity(
    priceInUsd: priceInUsd,
    currency: currency,
  );

  Map<String, dynamic> toJson() => {'price': priceInUsd, 'currency': currency};
}

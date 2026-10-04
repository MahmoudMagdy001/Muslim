import 'package:freezed_annotation/freezed_annotation.dart';

part 'gold_price_entity.freezed.dart';

@freezed
abstract class GoldPriceEntity with _$GoldPriceEntity {
  const factory GoldPriceEntity({
    required double priceInUsd,
    required String currency,
  }) = _GoldPriceEntity;
}

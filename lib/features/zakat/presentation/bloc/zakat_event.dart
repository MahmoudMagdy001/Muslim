import 'package:freezed_annotation/freezed_annotation.dart';

part 'zakat_event.freezed.dart';

@freezed
sealed class ZakatEvent with _$ZakatEvent {
  const factory ZakatEvent.loadGoldPrice() = ZakatLoadGoldPrice;
  const factory ZakatEvent.setManualGoldPrice(double price) = ZakatSetManualGoldPrice;
}

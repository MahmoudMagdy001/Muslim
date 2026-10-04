import 'package:freezed_annotation/freezed_annotation.dart';

part 'font_size_event.freezed.dart';

@freezed
sealed class FontSizeEvent with _$FontSizeEvent {
  const factory FontSizeEvent.setFontSize(double value) = FontSizeSetFontSize;
}

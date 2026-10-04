import 'package:freezed_annotation/freezed_annotation.dart';

part 'names_of_allah_event.freezed.dart';

@freezed
sealed class NamesOfAllahEvent with _$NamesOfAllahEvent {
  const factory NamesOfAllahEvent.getNamesOfAllah() = NamesOfAllahGetNamesOfAllah;
}

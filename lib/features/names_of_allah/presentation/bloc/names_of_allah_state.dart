import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:muslim/features/names_of_allah/domain/entities/name_of_allah_entity.dart';

part 'names_of_allah_state.freezed.dart';

@freezed
sealed class NamesOfAllahState with _$NamesOfAllahState {
  const factory NamesOfAllahState.initial() = NamesOfAllahInitial;
  const factory NamesOfAllahState.loading() = NamesOfAllahLoading;
  const factory NamesOfAllahState.loaded(List<NameOfAllahEntity> names) = NamesOfAllahLoaded;
  const factory NamesOfAllahState.error(String message) = NamesOfAllahError;
}

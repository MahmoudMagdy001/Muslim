import 'package:freezed_annotation/freezed_annotation.dart';

part 'name_of_allah_entity.freezed.dart';

@freezed
abstract class NameOfAllahEntity with _$NameOfAllahEntity {
  const factory NameOfAllahEntity({
    required int id,
    required String name,
    required String text,
    required String nameTranslation,
    required String textTranslation,
  }) = _NameOfAllahEntity;
}

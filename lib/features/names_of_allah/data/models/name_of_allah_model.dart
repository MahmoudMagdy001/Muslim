import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:muslim/features/names_of_allah/domain/entities/name_of_allah_entity.dart';

part 'name_of_allah_model.freezed.dart';

@Freezed(toJson: false, fromJson: false)
abstract class NameOfAllahModel with _$NameOfAllahModel {
  const NameOfAllahModel._();

  const factory NameOfAllahModel({
    required int id,
    required String name,
    required String text,
    required String nameTranslation,
    required String textTranslation,
  }) = _NameOfAllahModel;

  factory NameOfAllahModel.fromJson(Map<String, dynamic> json) =>
      NameOfAllahModel(
        id: json['id'] as int,
        name: json['name'] as String? ?? '',
        nameTranslation: json['name_translation'] as String? ?? '',
        text: json['text'] as String? ?? '',
        textTranslation: json['text_translation'] as String? ?? '',
      );

  NameOfAllahEntity toEntity() => NameOfAllahEntity(
    id: id,
    name: name,
    text: text,
    nameTranslation: nameTranslation,
    textTranslation: textTranslation,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'text': text,
    'name_translation': nameTranslation,
    'text_translation': textTranslation,
  };
}

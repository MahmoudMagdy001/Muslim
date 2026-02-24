import '../../domain/entities/name_of_allah_entity.dart';

class NameOfAllahModel extends NameOfAllahEntity {
  const NameOfAllahModel({
    required super.id,
    required super.name,
    required super.text,
    required super.nameTranslation,
    required super.textTranslation,
  });

  factory NameOfAllahModel.fromJson(Map<String, dynamic> json) =>
      NameOfAllahModel(
        id: json['id'] as int,
        name: json['name'] as String? ?? '',
        nameTranslation: json['name_translation'] as String? ?? '',
        text: json['text'] as String? ?? '',
        textTranslation: json['text_translation'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'text': text,
    'name_translation': nameTranslation,
    'text_translation': textTranslation,
  };
}

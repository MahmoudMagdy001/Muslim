import 'package:equatable/equatable.dart';

class NameOfAllahEntity extends Equatable {
  const NameOfAllahEntity({
    required this.id,
    required this.name,
    required this.text,
    required this.nameTranslation,
    required this.textTranslation,
  });

  final int id;
  final String name;
  final String text;
  final String nameTranslation;
  final String textTranslation;

  @override
  List<Object?> get props => [id, name, text, nameTranslation, textTranslation];
}

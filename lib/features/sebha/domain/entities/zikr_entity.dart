import 'package:equatable/equatable.dart';

class ZikrEntity extends Equatable {
  const ZikrEntity({
    required this.id,
    required this.textAr,
    required this.textEn,
    required this.count,
    this.isCustom = false,
  });

  final String id;
  final String textAr;
  final String textEn;
  final int count;
  final bool isCustom;

  @override
  List<Object?> get props => [id, textAr, textEn, count, isCustom];
}

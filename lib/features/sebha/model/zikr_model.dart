import 'dart:convert';

import 'package:equatable/equatable.dart';

class ZikrModel extends Equatable {
  const ZikrModel({
    required this.id,
    required this.textAr,
    required this.textEn,
    required this.count,
    this.isCustom = false,
  });

  factory ZikrModel.fromJson(Map<String, dynamic> json) => ZikrModel(
    id: json['id'] as String,
    textAr: json['textAr'] as String,
    textEn: json['textEn'] as String,
    count: json['count'] as int,
    isCustom: json['isCustom'] as bool? ?? false,
  );

  final String id;
  final String textAr;
  final String textEn;
  final int count;
  final bool isCustom;

  static const List<ZikrModel> defaultAzkar = [
    ZikrModel(
      id: 'default_1',
      textAr: 'سبحان الله',
      textEn: 'Subhan Allah',
      count: 33,
    ),
    ZikrModel(
      id: 'default_2',
      textAr: 'الحمد لله',
      textEn: 'Alhamdulillah',
      count: 33,
    ),
    ZikrModel(
      id: 'default_3',
      textAr: 'الله أكبر',
      textEn: 'Allahu Akbar',
      count: 34,
    ),
    ZikrModel(
      id: 'default_4',
      textAr: 'لا إله إلا الله',
      textEn: 'La ilaha illallah',
      count: 100,
    ),
  ];

  Map<String, dynamic> toJson() => {
    'id': id,
    'textAr': textAr,
    'textEn': textEn,
    'count': count,
    'isCustom': isCustom,
  };

  String toJsonString() => json.encode(toJson());

  ZikrModel copyWith({
    String? id,
    String? textAr,
    String? textEn,
    int? count,
    bool? isCustom,
  }) => ZikrModel(
    id: id ?? this.id,
    textAr: textAr ?? this.textAr,
    textEn: textEn ?? this.textEn,
    count: count ?? this.count,
    isCustom: isCustom ?? this.isCustom,
  );

  @override
  List<Object?> get props => [id, textAr, textEn, count, isCustom];
}

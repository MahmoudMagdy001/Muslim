import 'dart:convert';

import '../../domain/entities/zikr_entity.dart';

class ZikrModel extends ZikrEntity {
  const ZikrModel({
    required super.id,
    required super.textAr,
    required super.textEn,
    required super.count,
    super.isCustom = false,
  });

  factory ZikrModel.fromJson(Map<String, dynamic> json) => ZikrModel(
    id: json['id'] as String,
    textAr: json['textAr'] as String,
    textEn: json['textEn'] as String,
    count: json['count'] as int,
    isCustom: json['isCustom'] as bool? ?? false,
  );

  factory ZikrModel.fromEntity(ZikrEntity entity) => ZikrModel(
    id: entity.id,
    textAr: entity.textAr,
    textEn: entity.textEn,
    count: entity.count,
    isCustom: entity.isCustom,
  );

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
}

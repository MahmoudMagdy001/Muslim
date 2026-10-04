import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:muslim/features/sebha/domain/entities/zikr_entity.dart';

part 'zikr_model.freezed.dart';

@Freezed(toJson: false, fromJson: false)
abstract class ZikrModel with _$ZikrModel {
  const ZikrModel._();

  const factory ZikrModel({
    required String id,
    required String textAr,
    required String textEn,
    required int count,
    @Default(false) bool isCustom,
  }) = _ZikrModel;

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

  ZikrEntity toEntity() => ZikrEntity(
    id: id,
    textAr: textAr,
    textEn: textEn,
    count: count,
    isCustom: isCustom,
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
}

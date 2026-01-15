import 'dart:convert';

class ZikrModel {
  ZikrModel({
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

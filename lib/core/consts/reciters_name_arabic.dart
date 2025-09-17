import 'package:flutter/material.dart';

class Reciter {
  const Reciter({required this.id, required this.name});
  final String id;
  final String name;

  Map<String, String> toMap() => {'id': id, 'name': name};
}

const List<Reciter> recitersArabic = [
  Reciter(id: 'ar.minshawimujawwad', name: 'محمد صديق المنشاوي (المجود)'),
  Reciter(id: 'ar.abdulbasitmurattal', name: 'عبد الباسط عبد الصمد (المرتل)'),
  Reciter(id: 'ar.abdulsamad', name: 'عبدالباسط عبدالصمد'),
  Reciter(id: 'ar.alafasy', name: 'مشاري العفاسي'),
  Reciter(id: 'ar.husarymujawwad', name: 'محمود خليل الحصري (المجود)'),
  Reciter(id: 'ar.abdullahbasfar', name: 'عبد الله بصفر'),
  Reciter(id: 'ar.abdurrahmaansudais', name: 'عبدالرحمن السديس'),
  Reciter(id: 'ar.shaatree', name: 'أبو بكر الشاطري'),
  Reciter(id: 'ar.ahmedajamy', name: 'أحمد بن علي العجمي'),
  Reciter(id: 'ar.hanirifai', name: 'هاني الرفاعي'),
  Reciter(id: 'ar.husary', name: 'محمود خليل الحصري'),
  Reciter(id: 'ar.hudhaify', name: 'علي بن عبدالرحمن الحذيفي'),
  Reciter(id: 'ar.mahermuaiqly', name: 'ماهر المعيقلي'),
  Reciter(id: 'ar.saoodshuraym', name: 'سعود الشريم'),
  Reciter(id: 'ar.aymanswoaid', name: 'أيمن سويد'),
];

String getReciterName(String reciterId) {
  try {
    final reciter = recitersArabic.firstWhere(
      (r) => r.id == reciterId,
      orElse: () =>
          const Reciter(id: 'default', name: 'المصحف المرتل للشيخ عبدالباسط'),
    );
    return reciter.name;
  } catch (e) {
    debugPrint('Error getting reciter name: $e');
    return 'المصحف المرتل للشيخ عبدالباسط';
  }
}

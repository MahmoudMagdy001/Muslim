import 'package:flutter/material.dart';

class Reciter {
  const Reciter({required this.id, required this.nameAr, required this.nameEn});
  final String id;
  final String nameAr;
  final String nameEn;

  Map<String, String> toMap() => {'id': id, 'name': nameAr, 'nameEn': nameEn};
}

const List<Reciter> recitersNames = [
  Reciter(
    id: 'ar.minshawimujawwad',
    nameAr: 'محمد صديق المنشاوي (المجود)',
    nameEn: 'Mohamed Siddiq Al-Minshawi (Mujawwad)',
  ),
  Reciter(
    id: 'ar.abdulbasitmurattal',
    nameAr: 'عبد الباسط عبد الصمد (المرتل)',
    nameEn: 'Abdul Basit Abdus Samad (Murattal)',
  ),
  Reciter(
    id: 'ar.abdulsamad',
    nameAr: 'عبدالباسط عبدالصمد',
    nameEn: 'Abdul Basit Abdus Samad',
  ),
  Reciter(id: 'ar.alafasy', nameAr: 'مشاري العفاسي', nameEn: 'Mishary Alafasy'),
  Reciter(
    id: 'ar.husarymujawwad',
    nameAr: 'محمود خليل الحصري (المجود)',
    nameEn: 'Mahmoud Khalil Al-Husary (Mujawwad)',
  ),
  Reciter(
    id: 'ar.abdullahbasfar',
    nameAr: 'عبد الله بصفر',
    nameEn: 'Abdullah Basfar',
  ),
  Reciter(
    id: 'ar.abdurrahmaansudais',
    nameAr: 'عبدالرحمن السديس',
    nameEn: 'Abdurrahman As-Sudais',
  ),
  Reciter(
    id: 'ar.shaatree',
    nameAr: 'أبو بكر الشاطري',
    nameEn: 'Abu Bakr Ash-Shaatree',
  ),
  Reciter(
    id: 'ar.ahmedajamy',
    nameAr: 'أحمد بن علي العجمي',
    nameEn: 'Ahmed Al-Ajmi',
  ),
  Reciter(id: 'ar.hanirifai', nameAr: 'هاني الرفاعي', nameEn: 'Hani Ar-Rifai'),
  Reciter(
    id: 'ar.husary',
    nameAr: 'محمود خليل الحصري',
    nameEn: 'Mahmoud Khalil Al-Husary',
  ),
  Reciter(
    id: 'ar.hudhaify',
    nameAr: 'علي بن عبدالرحمن الحذيفي',
    nameEn: 'Ali Al-Hudhaify',
  ),
  Reciter(
    id: 'ar.mahermuaiqly',
    nameAr: 'ماهر المعيقلي',
    nameEn: 'Maher Al-Muaiqly',
  ),
  Reciter(
    id: 'ar.saoodshuraym',
    nameAr: 'سعود الشريم',
    nameEn: 'Saud Ash-Shuraim',
  ),
  Reciter(id: 'ar.aymanswoaid', nameAr: 'أيمن سويد', nameEn: 'Ayman Sowaid'),
];

String getReciterName(String reciterId, {bool isArabic = true}) {
  try {
    final reciter = recitersNames.firstWhere(
      (r) => r.id == reciterId,
      orElse: () => const Reciter(
        id: 'ar.alafasy',
        nameAr: 'مشاري العفاسي',
        nameEn: 'Mishary Alafasy',
      ),
    );

    return isArabic ? reciter.nameAr : reciter.nameEn;
  } catch (e) {
    debugPrint('Error getting reciter name: $e');
    return isArabic
        ? 'المصحف المرتل للشيخ عبدالباسط'
        : 'Abdul Basit Abdus Samad (Murattal)';
  }
}


import 'package:freezed_annotation/freezed_annotation.dart';

part 'zikr_entity.freezed.dart';

@freezed
abstract class ZikrEntity with _$ZikrEntity {
  const factory ZikrEntity({
    required String id,
    required String textAr,
    required String textEn,
    required int count,
    @Default(false) bool isCustom,
  }) = _ZikrEntity;

  static const List<ZikrEntity> defaultAzkar = [
    ZikrEntity(
      id: 'default_1',
      textAr: 'سبحان الله',
      textEn: 'Subhan Allah',
      count: 33,
    ),
    ZikrEntity(
      id: 'default_2',
      textAr: 'الحمد لله',
      textEn: 'Alhamdulillah',
      count: 33,
    ),
    ZikrEntity(
      id: 'default_3',
      textAr: 'الله أكبر',
      textEn: 'Allahu Akbar',
      count: 34,
    ),
    ZikrEntity(
      id: 'default_4',
      textAr: 'لا إله إلا الله',
      textEn: 'La ilaha illallah',
      count: 100,
    ),
  ];
}

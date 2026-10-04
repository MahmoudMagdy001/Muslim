import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:muslim/features/hadith/domain/entities/hadith_entity.dart';

part 'hadith_event.freezed.dart';

@freezed
sealed class HadithEvent with _$HadithEvent {
  const factory HadithEvent.initializeData({
    required String bookSlug,
    required String chapterNumber,
    required String chapterName,
  }) = HadithInitializeData;

  const factory HadithEvent.reloadData() = HadithReloadData;

  const factory HadithEvent.toggleHadithSave({
    required HadithEntity hadith,
    required bool isArabic,
  }) = HadithToggleHadithSave;
}

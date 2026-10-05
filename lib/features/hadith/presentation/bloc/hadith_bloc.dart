import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:muslim/features/hadith/domain/entities/hadith_entity.dart';
import 'package:muslim/features/hadith/domain/repositories/hadith_repository.dart';
import 'package:muslim/features/hadith/presentation/bloc/hadith_event.dart';
import 'package:muslim/features/hadith/presentation/bloc/hadith_state.dart';

export 'hadith_event.dart';
export 'hadith_state.dart';

class HadithBloc extends Bloc<HadithEvent, HadithState> {
  HadithBloc({
    required this.repository,
  }) : super(const HadithState()) {
    on<HadithInitializeData>(_onInitializeData);
    on<HadithReloadData>(_onReloadData);
    on<HadithToggleHadithSave>(_onToggleHadithSave);
  }

  final HadithRepository repository;

  String? _bookSlug;
  String? _chapterNumber;
  String? _chapterName;

  bool isHadithSaved(String hadithId) =>
      state.savedHadithIds.contains(hadithId);

  Future<void> _onInitializeData(
    HadithInitializeData event,
    Emitter<HadithState> emit,
  ) async {
    _bookSlug = event.bookSlug;
    _chapterNumber = event.chapterNumber;
    _chapterName = event.chapterName;

    emit(state.copyWith(status: HadithStatus.loading));

    final savedResult = await repository.getSavedHadiths();
    var savedHadiths = <Map<String, dynamic>>[];
    final savedIds = <String>{};

    savedResult.fold((failure) => null, (data) {
      savedHadiths = data;
      for (final h in data) {
        final id = h['id']?.toString();
        if (id != null) savedIds.add(id);
      }
    });

    final hadithsResult = await repository.getHadithsOfChapter(
      event.bookSlug,
      event.chapterNumber,
    );

    hadithsResult.fold(
      (failure) {
        emit(
          state.copyWith(
            status: HadithStatus.error,
            message: 'Failed to load hadiths',
          ),
        );
      },
      (hadiths) {
        emit(
          state.copyWith(
            status: HadithStatus.success,
            hadiths: hadiths,
            savedHadiths: savedHadiths,
            savedHadithIds: savedIds,
            dataLoaded: true,
          ),
        );
      },
    );
  }

  Future<void> _onReloadData(
    HadithReloadData event,
    Emitter<HadithState> emit,
  ) async {
    if (_bookSlug != null && _chapterNumber != null && _chapterName != null) {
      add(
        HadithEvent.initializeData(
          bookSlug: _bookSlug!,
          chapterNumber: _chapterNumber!,
          chapterName: _chapterName!,
        ),
      );
    }
  }

  Future<void> _onToggleHadithSave(
    HadithToggleHadithSave event,
    Emitter<HadithState> emit,
  ) async {
    if (_bookSlug == null || _chapterNumber == null || _chapterName == null) {
      return;
    }

    final id = event.hadith.id;
    final isCurrentlySaved = isHadithSaved(id);
    final previousSavedIds = Set<String>.from(state.savedHadithIds);
    final updatedIds = Set<String>.from(state.savedHadithIds);

    if (isCurrentlySaved) {
      updatedIds.remove(id);
      emit(state.copyWith(savedHadithIds: updatedIds));

      final result = await repository.removeHadith(id);
      result.fold(
        (failure) {
          emit(state.copyWith(savedHadithIds: previousSavedIds));
        },
        (_) => null,
      );
    } else {
      updatedIds.add(id);
      emit(state.copyWith(savedHadithIds: updatedIds));

      final data = {
        'id': id,
        'heading': event.isArabic
            ? event.hadith.headingArabic
            : event.hadith.headingEnglish,
        'text': event.isArabic
            ? event.hadith.hadithArabic
            : event.hadith.hadithEnglish,
        'status': event.isArabic
            ? getStatus(event.hadith.status)
            : event.hadith.status,
        'bookSlug': _bookSlug!,
        'chapterNumber': _chapterNumber!,
        'chapterName': _chapterName!,
      };

      final result = await repository.saveHadith(data);
      result.fold(
        (failure) {
          emit(state.copyWith(savedHadithIds: previousSavedIds));
        },
        (_) => null,
      );
    }
  }

  // Convenience methods
  Future<void> initializeData(
    String bookSlug,
    String chapterNumber,
    String chapterName,
  ) async {
    add(
      HadithEvent.initializeData(
        bookSlug: bookSlug,
        chapterNumber: chapterNumber,
        chapterName: chapterName,
      ),
    );
  }

  Future<void> reloadData() async => add(const HadithEvent.reloadData());

  Future<void> toggleHadithSave(HadithEntity hadith, {required bool isArabic}) async =>
      add(HadithEvent.toggleHadithSave(hadith: hadith, isArabic: isArabic));

  static const Map<String, String> _statusMap = {
    'Sahih': 'صحيح',
    'sahih': 'صحيح',
    'Hasan': 'حسن',
    'hasan': 'حسن',
    'Da`eef': 'ضعيف',
    'da`eef': 'ضعيف',
  };

  String getStatus(String status, {bool isArabic = true}) =>
      isArabic ? _statusMap[status] ?? status : status;
}

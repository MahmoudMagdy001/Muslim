import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/bookmark_model.dart';
import '../../service/bookmarks_service.dart';
import 'bookmarks_state.dart';

class BookmarksCubit extends Cubit<BookmarksState> {
  BookmarksCubit(this._service) : super(const BookmarksState());

  final BookmarksService _service;

  Future<void> load() async {
    emit(state.copyWith(status: BookmarksStatus.loading));
    try {
      final list = await _service.loadBookmarks();
      emit(state.copyWith(status: BookmarksStatus.ready, bookmarks: list));
    } catch (e) {
      emit(state.copyWith(status: BookmarksStatus.error, message: '$e'));
    }
  }

  Future<void> addBookmark({
    required int surah,
    required int ayah,
    required String ayahText,
  }) async {
    try {
      final updated = List<AyahBookmark>.from(state.bookmarks)
        ..removeWhere((b) => b.surahNumber == surah && b.ayahNumber == ayah)
        ..add(
          AyahBookmark(
            surahNumber: surah,
            ayahNumber: ayah,
            timestampMs: DateTime.now().millisecondsSinceEpoch,
            ayahText: ayahText,
          ),
        )
        ..sort((a, b) => b.timestampMs.compareTo(a.timestampMs));

      emit(state.copyWith(bookmarks: updated));
      await _service.saveBookmarks(updated);
    } catch (e) {
      // يمكنك إصدار حالة خطأ هنا إذا لزم الأمر
      debugPrint('Error adding bookmark: $e');
    }
  }

  Future<void> removeBookmark({required int surah, required int ayah}) async {
    try {
      final updated = List<AyahBookmark>.from(state.bookmarks)
        ..removeWhere((b) => b.surahNumber == surah && b.ayahNumber == ayah);

      emit(state.copyWith(bookmarks: updated));
      await _service.saveBookmarks(updated);
    } catch (e) {
      // يمكنك إصدار حالة خطأ هنا إذا لزم الأمر
      debugPrint('Error removing bookmark: $e');
    }
  }
}

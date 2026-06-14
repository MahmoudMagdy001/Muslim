import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:muslim/core/di/service_locator.dart';
import 'package:muslim/features/quran/model/bookmark_model.dart';
import 'package:muslim/features/quran/service/bookmarks_service.dart';
import 'package:muslim/features/quran/viewmodel/bookmarks_cubit/bookmarks_state.dart';

class BookmarksCubit extends Cubit<BookmarksState> {
  BookmarksCubit([BookmarksService? service])
    : _service = service ?? getIt<BookmarksService>(),
      super(const BookmarksState());

  final BookmarksService _service;

  Future<void> load() async {
    if (!isClosed) emit(state.copyWith(status: BookmarksStatus.loading));
    try {
      final list = await _service.loadBookmarks();
      if (!isClosed) {
        emit(state.copyWith(status: BookmarksStatus.ready, bookmarks: list));
      }
    } on Object catch (e) {
      if (!isClosed) {
        emit(state.copyWith(status: BookmarksStatus.error, message: '$e'));
      }
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

      if (!isClosed) emit(state.copyWith(bookmarks: updated));
      await _service.saveBookmarks(updated);
    } on Object catch (e) {
      // يمكنك إصدار حالة خطأ هنا إذا لزم الأمر
      debugPrint('Error adding bookmark: $e');
    }
  }

  Future<void> removeBookmark({required int surah, required int ayah}) async {
    try {
      final updated = List<AyahBookmark>.from(state.bookmarks)
        ..removeWhere((b) => b.surahNumber == surah && b.ayahNumber == ayah);

      if (!isClosed) emit(state.copyWith(bookmarks: updated));
      await _service.saveBookmarks(updated);
    } on Object catch (e) {
      // يمكنك إصدار حالة خطأ هنا إذا لزم الأمر
      debugPrint('Error removing bookmark: $e');
    }
  }
}

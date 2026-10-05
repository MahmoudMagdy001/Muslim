import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim/core/di/service_locator.dart';
import 'package:muslim/core/utils/app_logger.dart';
import 'package:muslim/features/quran/data/models/bookmark_model.dart';
import 'package:muslim/features/quran/data/services/bookmarks_service.dart';
import 'package:muslim/features/quran/presentation/bloc/bookmarks/bookmarks_event.dart';
import 'package:muslim/features/quran/presentation/bloc/bookmarks/bookmarks_state.dart';

export 'bookmarks_event.dart';

class BookmarksBloc extends Bloc<BookmarksEvent, BookmarksState> {
  BookmarksBloc([BookmarksService? service])
    : _service = service ?? getIt<BookmarksService>(),
      super(const BookmarksState()) {
    on<BookmarksLoad>(_onLoad);
    on<BookmarksAddBookmark>(_onAddBookmark);
    on<BookmarksRemoveBookmark>(_onRemoveBookmark);
  }

  final BookmarksService _service;

  Future<void> _onLoad(
    BookmarksLoad event,
    Emitter<BookmarksState> emit,
  ) async {
    emit(state.copyWith(status: BookmarksStatus.loading));
    try {
      final list = await _service.loadBookmarks();
      emit(state.copyWith(status: BookmarksStatus.ready, bookmarks: list));
    } on Object catch (e) {
      emit(state.copyWith(status: BookmarksStatus.error, message: '$e'));
    }
  }

  Future<void> _onAddBookmark(
    BookmarksAddBookmark event,
    Emitter<BookmarksState> emit,
  ) async {
    try {
      final updated = List<AyahBookmark>.from(state.bookmarks)
        ..removeWhere((b) => b.surahNumber == event.surah && b.ayahNumber == event.ayah)
        ..add(
          AyahBookmark(
            surahNumber: event.surah,
            ayahNumber: event.ayah,
            timestampMs: DateTime.now().millisecondsSinceEpoch,
            ayahText: event.ayahText,
          ),
        )
        ..sort((a, b) => b.timestampMs.compareTo(a.timestampMs));

      emit(state.copyWith(bookmarks: updated));
      await _service.saveBookmarks(updated);
    } on Object catch (e) {
      logError('Error adding bookmark', e);
    }
  }

  Future<void> _onRemoveBookmark(
    BookmarksRemoveBookmark event,
    Emitter<BookmarksState> emit,
  ) async {
    try {
      final updated = List<AyahBookmark>.from(state.bookmarks)
        ..removeWhere((b) => b.surahNumber == event.surah && b.ayahNumber == event.ayah);

      emit(state.copyWith(bookmarks: updated));
      await _service.saveBookmarks(updated);
    } on Object catch (e) {
      logError('Error removing bookmark', e);
    }
  }

  // Convenience methods
  Future<void> load() async {
    add(const BookmarksEvent.load());
    await stream.firstWhere((s) => s.status != BookmarksStatus.loading);
  }
  Future<void> addBookmark({
    required int surah,
    required int ayah,
    required String ayahText,
  }) async =>
      add(
        BookmarksEvent.addBookmark(
          surah: surah,
          ayah: ayah,
          ayahText: ayahText,
        ),
      );
  Future<void> removeBookmark({required int surah, required int ayah}) async =>
      add(BookmarksEvent.removeBookmark(surah: surah, ayah: ayah));
}

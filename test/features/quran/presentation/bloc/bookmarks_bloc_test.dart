import 'package:flutter_test/flutter_test.dart';
import 'package:muslim/features/quran/data/models/bookmark_model.dart';
import 'package:muslim/features/quran/data/services/bookmarks_service.dart';
import 'package:muslim/features/quran/presentation/bloc/bookmarks/bookmarks_bloc.dart';
import 'package:muslim/features/quran/presentation/bloc/bookmarks/bookmarks_state.dart';

class FakeBookmarksService extends BookmarksService {
  List<AyahBookmark> storage = [];

  @override
  Future<List<AyahBookmark>> loadBookmarks() async => storage;

  @override
  Future<void> saveBookmarks(List<AyahBookmark> bookmarks) async {
    storage = List.from(bookmarks);
  }
}

void main() {
  group('BookmarksBloc Tests', () {
    late FakeBookmarksService fakeService;
    late BookmarksBloc bloc;

    setUp(() {
      fakeService = FakeBookmarksService();
      bloc = BookmarksBloc(fakeService);
    });

    test('initial state has default status and empty list', () {
      expect(bloc.state.status, BookmarksStatus.initial);
      expect(bloc.state.bookmarks, isEmpty);
    });

    test('load loads bookmarks successfully into state', () async {
      fakeService.storage = [
        const AyahBookmark(
          surahNumber: 1,
          ayahNumber: 1,
          timestampMs: 1000,
          ayahText: 'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
        ),
      ];

      await bloc.load();

      expect(bloc.state.status, BookmarksStatus.ready);
      expect(bloc.state.bookmarks.length, 1);
      expect(bloc.state.bookmarks.first.surahNumber, 1);
    });

    test('addBookmark adds and persists a bookmark', () async {
      await bloc.addBookmark(surah: 2, ayah: 255, ayahText: 'اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ');

      expect(bloc.state.bookmarks.length, 1);
      expect(bloc.state.bookmarks.first.surahNumber, 2);
      expect(bloc.state.bookmarks.first.ayahNumber, 255);
      expect(fakeService.storage.length, 1);
    });

    test('removeBookmark removes existing bookmark and persists', () async {
      await bloc.addBookmark(surah: 2, ayah: 255, ayahText: 'اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ');

      expect(bloc.state.bookmarks.length, 1);

      await bloc.removeBookmark(surah: 2, ayah: 255);

      expect(bloc.state.bookmarks, isEmpty);
      expect(fakeService.storage, isEmpty);
    });
  });
}

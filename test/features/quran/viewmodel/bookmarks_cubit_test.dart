import 'package:flutter_test/flutter_test.dart';
import 'package:muslim/features/quran/model/bookmark_model.dart';
import 'package:muslim/features/quran/service/bookmarks_service.dart';
import 'package:muslim/features/quran/viewmodel/bookmarks_cubit/bookmarks_cubit.dart';
import 'package:muslim/features/quran/viewmodel/bookmarks_cubit/bookmarks_state.dart';

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
  group('BookmarksCubit Tests', () {
    late FakeBookmarksService fakeService;
    late BookmarksCubit cubit;

    setUp(() {
      fakeService = FakeBookmarksService();
      cubit = BookmarksCubit(fakeService);
    });

    test('initial state has default status and empty list', () {
      expect(cubit.state.status, BookmarksStatus.initial);
      expect(cubit.state.bookmarks, isEmpty);
    });

    test('load loads bookmarks successfully into state', () async {
      fakeService.storage = [
        AyahBookmark(
          surahNumber: 1,
          ayahNumber: 1,
          timestampMs: 1000,
          ayahText: 'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
        ),
      ];

      await cubit.load();

      expect(cubit.state.status, BookmarksStatus.ready);
      expect(cubit.state.bookmarks.length, 1);
      expect(cubit.state.bookmarks.first.surahNumber, 1);
    });

    test('addBookmark adds and persists a bookmark', () async {
      await cubit.addBookmark(surah: 2, ayah: 255, ayahText: 'اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ');

      expect(cubit.state.bookmarks.length, 1);
      expect(cubit.state.bookmarks.first.surahNumber, 2);
      expect(cubit.state.bookmarks.first.ayahNumber, 255);
      expect(fakeService.storage.length, 1);
    });

    test('removeBookmark removes existing bookmark and persists', () async {
      await cubit.addBookmark(surah: 2, ayah: 255, ayahText: 'اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ');

      expect(cubit.state.bookmarks.length, 1);

      await cubit.removeBookmark(surah: 2, ayah: 255);

      expect(cubit.state.bookmarks, isEmpty);
      expect(fakeService.storage, isEmpty);
    });
  });
}

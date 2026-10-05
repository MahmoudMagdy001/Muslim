import 'package:flutter_test/flutter_test.dart';
import 'package:muslim/core/error/exceptions.dart';
import 'package:muslim/core/error/failures.dart';
import 'package:muslim/features/azkar/data/datasources/azkar_audio_data_source.dart';
import 'package:muslim/features/azkar/data/datasources/azkar_local_data_source.dart';
import 'package:muslim/features/azkar/data/datasources/azkar_remote_data_source.dart';
import 'package:muslim/features/azkar/data/repositories/azkar_repository_impl.dart';
import 'package:muslim/features/azkar/domain/entities/azkar_audio_state.dart';

class FakeAzkarLocalDataSource implements AzkarLocalDataSource {
  Map<String, dynamic> localList = {
    'data': [
      {
        'ID': 27,
        'TITLE': 'أذكار الصباح والمساء',
        'eng_title': 'Words of remembrance',
        'slug': 'أذكار_الصباح_والمساء',
        'isFavorite': true,
        'CATEGORY': 'أذكار الصباح والمساء',
        'AUDIO_URL': 'https://www.hisnmuslim.com/audio/ar/ar_7esn_AlMoslem_by_Doors_028.mp3',
        'TEXT': 'https://www.hisnmuslim.com/api/ar/27.json',
      }
    ]
  };

  Map<String, Map<String, dynamic>> localContentMap = {};
  Map<String, int> counts = {};

  @override
  Future<Map<String, dynamic>> loadAzkarFromAssets() async => localList;

  @override
  Future<Map<String, dynamic>?> getAzkarContent(String sourceUrl) async =>
      localContentMap[sourceUrl];

  @override
  Future<void> cacheAzkarContent(
    String sourceUrl,
    Map<String, dynamic> data,
  ) async {
    localContentMap[sourceUrl] = data;
  }

  @override
  Future<int?> getCount(String sourceUrl, int index) async =>
      counts['${sourceUrl}_$index'];

  @override
  Future<void> saveCount(String sourceUrl, int index, int count) async {
    counts['${sourceUrl}_$index'] = count;
  }

  @override
  Future<void> clearIfNewDay() async {}
}

class FakeAzkarRemoteDataSource implements AzkarRemoteDataSource {
  Map<String, dynamic>? responseToReturn;
  bool shouldThrow = false;
  int callCount = 0;

  @override
  Future<Map<String, dynamic>> fetchAzkarContent(String url) async {
    callCount++;
    if (shouldThrow) {
      throw const ServerException('Remote connection error');
    }
    return responseToReturn ?? {};
  }
}

class FakeAzkarAudioDataSource implements AzkarAudioDataSource {
  @override
  AzkarAudioState get currentState =>
      const AzkarAudioState(status: AzkarAudioStatus.initial);

  @override
  Stream<AzkarAudioState> get stateStream => const Stream.empty();

  @override
  void dispose() {}

  @override
  Future<void> play(String url, {String? title}) async {}

  @override
  Future<void> stop() async {}
}

void main() {
  group('AzkarRepositoryImpl Tests', () {
    late FakeAzkarLocalDataSource localDataSource;
    late FakeAzkarRemoteDataSource remoteDataSource;
    late FakeAzkarAudioDataSource audioDataSource;
    late AzkarRepositoryImpl repository;

    setUp(() {
      localDataSource = FakeAzkarLocalDataSource();
      remoteDataSource = FakeAzkarRemoteDataSource();
      audioDataSource = FakeAzkarAudioDataSource();
      repository = AzkarRepositoryImpl(
        remoteDataSource,
        localDataSource,
        audioDataSource,
      );
    });

    test('getAzkarList successfully returns categories from local assets', () async {
      final result = await repository.getAzkarList();
      expect(result.isRight(), isTrue);
      result.fold(
        (failure) => fail('Should not fail'),
        (list) {
          expect(list.length, 1);
          expect(list.first.id, 27);
          expect(list.first.title, 'أذكار الصباح والمساء');
        },
      );
    });

    test('getAzkarContent returns instantly from local datasource without calling remote', () async {
      const url = 'https://www.hisnmuslim.com/api/ar/27.json';
      localDataSource.localContentMap[url] = {
        'أذكار': [
          {
            'ID': 1,
            'ARABIC_TEXT': 'سبحان الله وبحمده',
            'TRANSLATED_TEXT': '',
            'REPEAT': 100,
            'AUDIO': 'https://www.hisnmuslim.com/audio/ar/1.mp3',
          }
        ]
      };

      final result = await repository.getAzkarContent(url);

      expect(remoteDataSource.callCount, 0); // Did NOT touch remote!
      expect(result.isRight(), isTrue);
      result.fold(
        (failure) => fail('Should not fail'),
        (content) {
          expect(content.length, 1);
          expect(content.first.arabicText, 'سبحان الله وبحمده');
          expect(content.first.repeat, 100);
        },
      );
    });

    test('getAzkarContent falls back to remote and caches locally when missing from local', () async {
      const url = 'https://www.hisnmuslim.com/api/ar/99.json';
      remoteDataSource.responseToReturn = {
        'أذكار': [
          {
            'ID': 99,
            'ARABIC_TEXT': 'أستغفر الله وأتوب إليه',
            'TRANSLATED_TEXT': '',
            'REPEAT': 70,
            'AUDIO': '',
          }
        ]
      };

      final result = await repository.getAzkarContent(url);

      expect(remoteDataSource.callCount, 1);
      expect(localDataSource.localContentMap.containsKey(url), isTrue);
      expect(result.isRight(), isTrue);
      result.fold(
        (failure) => fail('Should not fail'),
        (content) {
          expect(content.length, 1);
          expect(content.first.arabicText, 'أستغفر الله وأتوب إليه');
          expect(content.first.repeat, 70);
        },
      );
    });

    test('getAzkarContent returns ServerFailure when remote fails and not in local', () async {
      const url = 'https://www.hisnmuslim.com/api/ar/999.json';
      remoteDataSource.shouldThrow = true;

      final result = await repository.getAzkarContent(url);

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) {
          expect(failure, isA<ServerFailure>());
        },
        (content) => fail('Should have failed'),
      );
    });
  });
}

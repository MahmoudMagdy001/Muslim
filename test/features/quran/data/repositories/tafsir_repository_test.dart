import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:muslim/features/quran/data/repositories/tafsir_repository.dart';

void main() {
  group('TafsirRepository', () {
    test('fetches tafsir successfully from QuranCDN primary endpoint', () async {
      final mockClient = MockClient((request) async {
        expect(request.url.scheme, 'https');
        expect(request.url.host, 'api.qurancdn.com');
        expect(request.url.path, '/api/v4/tafsirs/ar-tafsir-muyassar/by_ayah/1:1');

        return http.Response(
          jsonEncode({
            'tafsir': {
              'id': 1,
              'text': 'سورة الفاتحة سميت هذه السورة بالفاتحة...',
            },
          }),
          200,
          headers: {'content-type': 'application/json'},
        );
      });

      final repository = TafsirRepository(client: mockClient);
      final result = await repository.fetchTafsirById(1, 1, 1);

      expect(result, 'سورة الفاتحة سميت هذه السورة بالفاتحة...');
    });

    test('falls back to QuranEnc when QuranCDN fails', () async {
      final mockClient = MockClient((request) async {
        if (request.url.host == 'api.qurancdn.com') {
          return http.Response('Error', 500);
        }
        if (request.url.host == 'quranenc.com') {
          return http.Response(
            jsonEncode({
              'result': {
                'translation': 'تفسير مجمع الملك فهد',
              },
            }),
            200,
            headers: {'content-type': 'application/json'},
          );
        }
        return http.Response('Not Found', 404);
      });

      final repository = TafsirRepository(client: mockClient);
      final result = await repository.fetchTafsirById(1, 1, 1);

      expect(result, 'تفسير مجمع الملك فهد');
    });

    test('falls back to legacy API with List response when CDN and QuranEnc fail', () async {
      final mockClient = MockClient((request) async {
        if (request.url.host == 'api.qurancdn.com' || request.url.host == 'quranenc.com') {
          return http.Response('Error', 500);
        }
        return http.Response(
          jsonEncode([
            {
              'tafseer_id': 1,
              'tafseer_name': 'التفسير الميسر',
              'text': 'تفسير الآية في قائمة',
            }
          ]),
          200,
          headers: {'content-type': 'application/json'},
        );
      });

      final repository = TafsirRepository(client: mockClient);
      final result = await repository.fetchTafsirById(1, 2, 3);

      expect(result, 'تفسير الآية في قائمة');
    });

    test('returns cached result on second call without new HTTP request', () async {
      var requestCount = 0;
      final mockClient = MockClient((request) async {
        requestCount++;
        return http.Response(
          jsonEncode({
            'tafsir': {'text': 'تفسير محفوظ'},
          }),
          200,
          headers: {'content-type': 'application/json'},
        );
      });

      final repository = TafsirRepository(client: mockClient);
      final firstResult = await repository.fetchTafsirById(1, 1, 1);
      final secondResult = await repository.fetchTafsirById(1, 1, 1);

      expect(firstResult, 'تفسير محفوظ');
      expect(secondResult, 'تفسير محفوظ');
      expect(requestCount, 1);
    });

    test('returns error message when all HTTP responses fail', () async {
      final mockClient = MockClient(
        (request) async => http.Response('Internal Server Error', 500),
      );

      final repository = TafsirRepository(client: mockClient);
      final result = await repository.fetchTafsirById(1, 1, 1);

      expect(result, 'تعذر جلب التفسير. تأكد من الاتصال بالإنترنت.');
    });

    test('returns fallback message when response text is empty across endpoints', () async {
      final mockClient = MockClient(
        (request) async => http.Response(
          jsonEncode({'tafsir': {'text': ''}, 'result': {'translation': ''}, 'text': ''}),
          200,
          headers: {'content-type': 'application/json'},
        ),
      );

      final repository = TafsirRepository(client: mockClient);
      final result = await repository.fetchTafsirById(1, 1, 1);

      expect(result, 'تعذر جلب التفسير. تأكد من الاتصال بالإنترنت.');
    });

    test('returns fallback message when exception is thrown', () async {
      final mockClient = MockClient((request) async {
        throw Exception('Connection failed');
      });

      final repository = TafsirRepository(client: mockClient);
      final result = await repository.fetchTafsirById(1, 1, 1);

      expect(result, 'تعذر جلب التفسير. تأكد من الاتصال بالإنترنت.');
    });
  });
}

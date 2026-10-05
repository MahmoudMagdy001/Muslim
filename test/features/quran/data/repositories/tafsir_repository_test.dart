import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:muslim/features/quran/data/repositories/tafsir_repository.dart';

void main() {
  group('TafsirRepository', () {
    test('fetches tafsir successfully from Map response', () async {
      final mockClient = MockClient((request) async {
        expect(request.url.scheme, 'http');
        expect(request.url.host, 'api.quran-tafseer.com');
        expect(request.url.path, '/tafseer/1/1/1');

        return http.Response(
          jsonEncode({
            'tafseer_id': 1,
            'tafseer_name': 'التفسير الميسر',
            'ayah_url': '/quran/1/1/',
            'ayah_number': 1,
            'text': 'سورة الفاتحة سميت هذه السورة بالفاتحة...',
          }),
          200,
          headers: {'content-type': 'application/json'},
        );
      });

      final repository = TafsirRepository(client: mockClient);
      final result = await repository.fetchTafsirById(1, 1, 1);

      expect(result, 'سورة الفاتحة سميت هذه السورة بالفاتحة...');
    });

    test('fetches tafsir successfully from List response', () async {
      final mockClient = MockClient((request) async {
        expect(request.url.scheme, 'http');
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
          jsonEncode({'text': 'تفسير محفوظ'}),
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

    test('returns error message when HTTP response is not 200', () async {
      final mockClient = MockClient(
        (request) async => http.Response('Internal Server Error', 500),
      );

      final repository = TafsirRepository(client: mockClient);
      final result = await repository.fetchTafsirById(1, 1, 1);

      expect(result, 'حدث خطأ أثناء تحميل التفسير (500).');
    });

    test('returns fallback message when response text is empty', () async {
      final mockClient = MockClient(
        (request) async => http.Response(
          jsonEncode({'text': ''}),
          200,
          headers: {'content-type': 'application/json'},
        ),
      );

      final repository = TafsirRepository(client: mockClient);
      final result = await repository.fetchTafsirById(1, 1, 1);

      expect(result, 'لم يتم العثور على تفسير لهذه الآية.');
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

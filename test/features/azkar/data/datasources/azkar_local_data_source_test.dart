import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:muslim/features/azkar/data/datasources/azkar_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AzkarLocalDataSourceImpl Tests', () {
    late AzkarLocalDataSourceImpl dataSource;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      dataSource = AzkarLocalDataSourceImpl();

      // Intercept rootBundle to load real files from disk during flutter test
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMessageHandler('flutter/assets', (message) async {
        final key = utf8.decode(message!.buffer.asUint8List());
        final file = File(key);
        if (file.existsSync()) {
          final bytes = await file.readAsBytes();
          return ByteData.view(bytes.buffer);
        }
        return null;
      });
    });

    test('loadAzkarFromAssets returns categories list from assets/json/zekr.json', () async {
      final json = await dataSource.loadAzkarFromAssets();
      expect(json.containsKey('data'), isTrue);
      final data = json['data'] as List;
      expect(data.isNotEmpty, isTrue);
      expect(data.length, 132);
    });

    test('getAzkarContent resolves content from bundled hisn_muslim_content.json for URL', () async {
      // URL for Morning and Evening Azkar (ID 27)
      const url = 'https://www.hisnmuslim.com/api/ar/27.json';
      final content = await dataSource.getAzkarContent(url);

      expect(content, isNotNull);
      expect(content!.isNotEmpty, isTrue);
      final list = content.values.first as List;
      expect(list.length, greaterThan(0));
    });

    test('getAzkarContent resolves content for all 132 Hisn Muslim IDs', () async {
      for (var id = 1; id <= 132; id++) {
        final url = 'https://www.hisnmuslim.com/api/ar/$id.json';
        final content = await dataSource.getAzkarContent(url);
        expect(content, isNotNull, reason: 'ID $id should be found in bundled content');
        expect(content!.values.first, isNotEmpty);
      }
    });

    test('saveCount and getCount persist and read count accurately', () async {
      const url = 'https://www.hisnmuslim.com/api/ar/27.json';
      await dataSource.saveCount(url, 0, 5);

      final count = await dataSource.getCount(url, 0);
      expect(count, 5);
    });
  });
}

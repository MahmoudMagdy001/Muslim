import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:muslim/core/error/exceptions.dart';

abstract class AzkarRemoteDataSource {
  Future<Map<String, dynamic>> fetchAzkarContent(String url);
}

class AzkarRemoteDataSourceImpl implements AzkarRemoteDataSource {
  @override
  Future<Map<String, dynamic>> fetchAzkarContent(String url) async {
    try {
      var secureUrl = url;
      if (secureUrl.startsWith('http://')) {
        secureUrl = secureUrl.replaceFirst('http://', 'https://');
      }

      final response = await http.get(
        Uri.parse(secureUrl),
        headers: {
          'User-Agent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        // Handle potential BOM (Byte Order Mark) or encoding issues
        var body = utf8.decode(response.bodyBytes);
        // The API response starts with a BOM sometimes or follows a specific structure
        // Let's strip any non-json characters if they exist at the start
        if (body.startsWith('\uFEFF')) {
          body = body.substring(1);
        }
        return json.decode(body) as Map<String, dynamic>;
      } else {
        throw const ServerException('Failed to fetch from server');
      }
    } on ServerException {
      rethrow;
    } on Object catch (_) {
      throw const ServerException('Failed to connect to server');
    }
  }
}

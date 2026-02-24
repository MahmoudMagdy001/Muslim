import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../../core/error/failures.dart';

abstract class AzkarRemoteDataSource {
  Future<Map<String, dynamic>> fetchAzkarContent(String url);
}

class AzkarRemoteDataSourceImpl implements AzkarRemoteDataSource {
  @override
  Future<Map<String, dynamic>> fetchAzkarContent(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // Handle potential BOM (Byte Order Mark) or encoding issues
        String body = utf8.decode(response.bodyBytes);
        // The API response starts with a BOM sometimes or follows a specific structure
        // Let's strip any non-json characters if they exist at the start
        if (body.startsWith('\uFEFF')) {
          body = body.substring(1);
        }
        return json.decode(body) as Map<String, dynamic>;
      } else {
        throw const ServerFailure('Failed to fetch from server');
      }
    } on ServerFailure {
      rethrow;
    } catch (e) {
      throw const ServerFailure('Failed to connect to server');
    }
  }
}

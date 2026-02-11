import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class AzkarService {
  Future<Map<String, dynamic>> loadAzkarFromAssets() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/json/zekr.json',
      );
      return json.decode(response) as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }

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
        throw Exception('Failed to load azkar content');
      }
    } catch (e) {
      rethrow;
    }
  }
}

import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import '../model/prayer_times_model.dart';

class PrayerTimesService {
  Future<PrayerTimesResponse> getPrayerTimes() async {
 
    final position = await Geolocator.getCurrentPosition();

    final url = Uri.https('api.aladhan.com', '/v1/timings', {
      'latitude': '${position.latitude}',
      'longitude': '${position.longitude}',
      'method': '5',
    });

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return PrayerTimesResponse.fromJson(json);
    } else {
      throw Exception('حصل خطأ: ${response.statusCode}');
    }
  }


}

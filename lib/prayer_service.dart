<<<<<<< HEAD
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// A simple mock prayer service. Replace with a real calculation or API.
class PrayerService {
  PrayerService();

  Map<String, String> getTodayTimes() {
    final now = DateTime.now();
    final fmt = DateFormat.Hm();
    return {
      'Fajr': fmt.format(DateTime(now.year, now.month, now.day, 5, 10)),
      'Dhuhr': fmt.format(DateTime(now.year, now.month, now.day, 12, 30)),
      'Asr': fmt.format(DateTime(now.year, now.month, now.day, 16, 00)),
      'Maghrib': fmt.format(DateTime(now.year, now.month, now.day, 18, 15)),
      'Isha': fmt.format(DateTime(now.year, now.month, now.day, 19, 45)),
    };
  }

  Future<void> initializeTimeZone() async {
    tz.initializeTimeZones();
  }
}
=======
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/prayer_times.dart';

class PrayerTimeService {
  static const String _apiUrl = 'http://api.aladhan.com/v1/timings';

  static Future<PrayerTimes> getPrayerTimes(double latitude, double longitude) async {
    try {
      final response = await http.get(
        Uri.parse('$_apiUrl?latitude=$latitude&longitude=$longitude&method=2'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final timings = data['data']['timings'];
        return PrayerTimes.fromJson(timings);
      } else {
        throw Exception('Failed to load prayer times');
      }
    } catch (e) {
      // Return default times if API fails
      return PrayerTimes(
        fajr: '05:00',
        sunrise: '06:00',
        dhuhr: '12:00',
        asr: '15:00',
        maghrib: '18:00',
        isha: '19:00',
      );
    }
  }

  static String getNextPrayer(PrayerTimes times) {
    final now = DateTime.now();
    final currentTime = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    
    final prayerTimes = [
      {'name': 'Fajr', 'time': times.fajr},
      {'name': 'Dhuhr', 'time': times.dhuhr},
      {'name': 'Asr', 'time': times.asr},
      {'name': 'Maghrib', 'time': times.maghrib},
      {'name': 'Isha', 'time': times.isha},
    ];

    for (var prayer in prayerTimes) {
      if (_isTimeAfter(currentTime, prayer['time']!)) {
        return prayer['name']!;
      }
    }
    
    return 'Fajr'; // Default to Fajr if all prayers passed
  }

  static bool _isTimeAfter(String currentTime, String prayerTime) {
    return currentTime.compareTo(prayerTime) < 0;
  }
}
>>>>>>> 7ec5718979b9eadf2590c06d23ed5ed6e78170e0

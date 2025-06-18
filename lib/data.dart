import 'package:shared_preferences/shared_preferences.dart';

class LocationStorage {
  static double latitude = 41.85003;
  static double longitude = -87.65005;
  static String city = "Chicago";
  static bool fahrenheit = false;
  static bool update = false;

  static Future<void> Save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('latitude', latitude);
    await prefs.setDouble('longitude', longitude);
    await prefs.setBool("fahrenheit", fahrenheit);
    await prefs.setString("city", city);
  }
  static Future<void> Load() async {
    final prefs = await SharedPreferences.getInstance();
    latitude = prefs.getDouble('latitude') ?? latitude;
    longitude = prefs.getDouble('longitude') ?? longitude;
    fahrenheit = prefs.getBool('fahrenheit') ?? false;
    city = prefs.getString('city') ?? city;
  }
}
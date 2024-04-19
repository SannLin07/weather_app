import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_models.dart';

class WeatherService {
  static const Base_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey = "20b89745bd1001dfa882c54120fced88";

  Future<Weather> getWeather(double latitude, double longitude) async {
    try {
      final response = await http.get(Uri.parse(
          '$Base_URL?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric'));

      if (response.statusCode == 200) {
        print("Weather data fetched successfully");
        return Weather.fromJson(jsonDecode(response.body));
      } else {
        print("Failed to load weather data: ${response.statusCode}");
        throw Exception("Failed to load weather data");
      }
    } catch (e) {
      print("Exception while fetching weather data: $e");
      throw Exception("Failed to load weather data");
    }
  }
}

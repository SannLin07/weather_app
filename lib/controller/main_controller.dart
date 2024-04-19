import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather/service/weather_service.dart';

class MainController extends GetxController {
  late Position _currentPosition;
  late WeatherService weatherService;

  @override
  void onInit() {
    super.onInit();
    weatherService = WeatherService();
    _checkPermission();
  }

  Future<Position> getLocation() async {
    try {
      _currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      print('Latitude: ${_currentPosition.latitude}');
      print('Longitude: ${_currentPosition.longitude}');
      await getWeather(_currentPosition.latitude, _currentPosition.longitude);
      return _currentPosition; // Return _currentPosition directly
    } catch (e) {
      print('Error getting location: $e');
      throw e; // Rethrow the error so that FutureBuilder can catch it
    }
  }

  Future<void> getWeather(double latitude, double longitude) async {
    try {
      final weather = await weatherService.getWeather(latitude, longitude);
      print('Weather: $weather');
    } catch (e) {
      print('Error fetching weather: $e');
    }
  }

  Future<void> _checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, handle it gracefully.
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied, request open settings.
      return;
    }

    // Permissions are granted, fetch the location.
    await getLocation();
  }
}

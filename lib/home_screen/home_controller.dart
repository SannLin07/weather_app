import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather/models/weather_models.dart';

import 'package:weather/service/weather_service.dart';

import 'home_widgets.dart';

class HomeScreenController extends GetxController {
  HomeScreenController();

  Weather? weather;

  DateTime now = DateTime.now();
  late final StreamController<DateTime> _streamController;
  final loadingProgress = const CircularProgressIndicator.adaptive();

  @override
  void onInit() {
    _streamController = StreamController<DateTime>();
    super.onInit();
  }

  @override
  void onClose() {
    _streamController.close();
    super.onClose();
  }

  // Fetch weather data
  void fetchWeatherData(double latitude, double longitude) async {
    try {
      WeatherService weatherService = WeatherService();
      Weather fetchedWeather =
          await weatherService.getWeather(latitude, longitude);

      weather = fetchedWeather;

      update();
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching weather data: $e');
    }
  }

  //Widgets

  Widget mainBoard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(6),
        width: double.infinity,
        height: 280,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 185, 190, 189),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat("EEEE, dd MMM").format(now),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
                child: Center(
              child: weather != null
                  ? Image.network(
                      'https://openweathermap.org/img/wn/${weather!.icon}.png',
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    )
                  : Center(child: loadingProgress),
            )),
            const SizedBox(height: 8),
            Text(
              "${weather?.temp ?? 0}°",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "${weather?.description ?? 0}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${weather?.tempMax.roundToDouble() ?? 0}° / ${weather?.tempMin.roundToDouble() ?? 0}°',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget feelLikeBoard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(6.0),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 185, 190, 189),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        height: 168,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Real feel",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            Expanded(
              child: temperatureMonitor(),
            ),
          ],
        ),
      ),
    );
  }

  Widget windSpeedBoard() {
    return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.all(6.0),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 185, 190, 189),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          height: 168,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Wind speed",
                style: TextStyle(
                    fontSize: 13.8,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                  height: 110, width: double.infinity, child: windSpeedRange())
            ],
          ),
        ));
  }

  Widget humidityBoard() {
    return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.all(6.0),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 185, 190, 189),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          height: 168,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Humidity",
                style: TextStyle(
                  fontSize: 13.8,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Expanded(child: humidityElevation())
            ],
          ),
        ));
  }

  Widget sunSetRiseBoard() {
    DateTime sunriseDateTime = DateTime.fromMillisecondsSinceEpoch(
      (controller.weather?.sunrise ?? 0) * 1000,
    );
    DateTime sunsetDateTime = DateTime.fromMillisecondsSinceEpoch(
      (controller.weather?.sunset ?? 0) * 1000,
    );

    int sunriseHour = sunriseDateTime.hour;
    int sunriseMinute = sunriseDateTime.minute;

    int sunsetHour = sunsetDateTime.hour;
    int sunsetMinute = sunsetDateTime.minute;

    return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.all(6.0),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 185, 190, 189),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          height: 168,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Sunrise & Sunset",
                style: TextStyle(
                  fontSize: 13.8,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '$sunriseHour:${sunriseMinute}am',
                    style: const TextStyle(color: Colors.green, fontSize: 8.8),
                  ),
                  Text(
                    '$sunsetHour:${sunsetMinute}pm',
                    style: const TextStyle(color: Colors.red, fontSize: 8.8),
                  ),
                ],
              ),
              Expanded(child: sunSetRiseMonitor())
            ],
          ),
        ));
  }

  Widget pressureBoard() {
    return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.all(6.0),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 185, 190, 189),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          height: 168,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Pressure",
                    style: TextStyle(
                        fontSize: 13.8,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "${weather?.pressure ?? 0}",
                    style: const TextStyle(
                        fontSize: 13.8,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Expanded(child: windPressureMonitor())
            ],
          ),
        ));
  }

  Widget windDirectionBoard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(6.0),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 185, 190, 189),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        height: 168,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Direction",
                  style: TextStyle(
                    fontSize: 13.8,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${weather?.windDeg.round() ?? 0}',
                  style: const TextStyle(
                    fontSize: 13.8,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
            Expanded(
              child: compass(),
            ),
          ],
        ),
      ),
    );
  }
}

Widget explainBoard() {
  return Drawer(
    child: Container(
      color: Colors.grey[200],
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 185, 190, 189),
            ),
            child: Center(
              child: Text(
                'Unit Explanation',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
            ),
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Temperature',
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                  '°C (Celsius)',
                  style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Speed',
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                  'mph (Miles per hour)',
                  style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Pressure',
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                  'hPa (Hectopascal)',
                  style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

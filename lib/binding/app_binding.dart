import 'package:get/get.dart';

import 'package:weather/controller/main_controller.dart';

import 'package:weather/service/weather_service.dart';
import 'package:weather/splash/splash_controller.dart';

import '../home_screen/home_controller.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeScreenController());
    Get.put(WeatherService());
    Get.put(MainController());
    Get.put(SplashController());
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:weather/splash/splash_screen.dart';
import 'Binding/app_binding.dart';
import 'controller/main_controller.dart';
import 'home_screen/home_controller.dart';
import 'home_screen/home_screen.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainController());
    final ctr = Get.put(HomeScreenController());
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp]); // Lock screen rotate vertical
    return FutureBuilder<Position>(
      future: controller.getLocation(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.system,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            initialBinding: AppBinding(),
            onInit: () => ctr.fetchWeatherData(
                snapshot.data!.latitude, snapshot.data!.longitude),
            home: const HomeScreen());
      },
    );
  }
}

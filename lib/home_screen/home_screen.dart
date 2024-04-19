import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';


class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 185, 190, 189),
          title: Row(
            children: [
              const Icon(Icons.location_pin),
              const SizedBox(
                width: 6,
              ),
              GetBuilder<HomeScreenController>(
                builder: (controller) {
                  return Text(
                    ' ${controller.weather?.cityName ?? "?"}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  );
                },
              ),
            ],
          ),
        ),
        endDrawer: explainBoard(),
        body: GetBuilder<HomeScreenController>(
          builder: (controller) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FractionallySizedBox(
                  widthFactor: 1.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      controller.mainBoard(),
                      const SizedBox(
                        height: 8,
                      ),
                      AspectRatio(
                        aspectRatio: 2.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: controller.feelLikeBoard()),
                            const SizedBox(width: 8),
                            Expanded(child: controller.humidityBoard()),
                          ],
                        ),
                      ),
                      AspectRatio(
                        aspectRatio: 2.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: controller.windSpeedBoard()),
                            const SizedBox(width: 8),
                            Expanded(child: controller.windDirectionBoard()),
                          ],
                        ),
                      ),
                      AspectRatio(
                        aspectRatio: 2.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: controller.pressureBoard()),
                            const SizedBox(width: 8),
                            Expanded(child: controller.sunSetRiseBoard()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

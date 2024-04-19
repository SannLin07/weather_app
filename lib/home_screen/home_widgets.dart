import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import '../../models/chart_data.dart';
import 'home_controller.dart';

final controller = Get.put(HomeScreenController());


Widget temperatureMonitor() {
  return SfRadialGauge(
    animationDuration: 3500,
    enableLoadingAnimation: true,
    axes: <RadialAxis>[
      RadialAxis(
          minimum: -50,
          maximum: 150.1,
          interval: 25.0,
          minorTicksPerInterval: 10,
          showAxisLine: false,
          radiusFactor: 0.75,
          labelOffset: 5,
          ranges: <GaugeRange>[
            GaugeRange(
                startValue: -50,
                endValue: 0,
                startWidth: 0.265,
                sizeUnit: GaugeSizeUnit.factor,
                endWidth: 0.265,
                color: const Color.fromRGBO(34, 144, 199, 0.75)),
            GaugeRange(
                startValue: 0,
                endValue: 10,
                startWidth: 0.265,
                sizeUnit: GaugeSizeUnit.factor,
                endWidth: 0.265,
                color: const Color.fromRGBO(34, 195, 199, 0.75)),
            GaugeRange(
                startValue: 10,
                endValue: 30,
                startWidth: 0.265,
                sizeUnit: GaugeSizeUnit.factor,
                endWidth: 0.265,
                color: const Color.fromRGBO(123, 199, 34, 0.75)),
            GaugeRange(
                startValue: 30,
                endValue: 40,
                startWidth: 0.265,
                sizeUnit: GaugeSizeUnit.factor,
                endWidth: 0.265,
                color: const Color.fromRGBO(238, 193, 34, 0.75)),
            GaugeRange(
                startValue: 40,
                endValue: 150,
                startWidth: 0.265,
                sizeUnit: GaugeSizeUnit.factor,
                endWidth: 0.265,
                color: const Color.fromRGBO(238, 79, 34, 0.65)),
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
                angle: 90,
                positionFactor: 0.8,
                widget: Text('${controller.weather?.feelsLike ??0}°C',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 247, 64, 2), fontSize: 10))),
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
              value: controller.weather != null
                  ? controller.weather!.feelsLike
                  : 0.0,
              needleStartWidth: 0,
              needleEndWidth: 3.6,
              animationType: AnimationType.easeOutBack,
              enableAnimation: true,
              animationDuration: 1200,
              knobStyle: const KnobStyle(
                  knobRadius: 0.06,
                  borderColor: Color(0xFFF8B195),
                  color: Colors.white,
                  borderWidth: 0.04),
              tailStyle: const TailStyle(
                  color: Color.fromARGB(255, 248, 177, 149),
                  width: 0,
                  length: 0.0),
              needleColor: const Color(0xFFF8B195),
            )
          ],
          axisLabelStyle: const GaugeTextStyle(fontSize: 8),
          majorTickStyle: const MajorTickStyle(
              length: 0.12, lengthUnit: GaugeSizeUnit.factor),
          minorTickStyle: const MinorTickStyle(
              length: 0.13, lengthUnit: GaugeSizeUnit.factor, thickness: 1.5))
    ],
  );
}

Widget compass() {
  double windDirection =
      controller.weather != null ? controller.weather!.windDeg : 0.0;
  return SfRadialGauge(
    axes: <RadialAxis>[
      RadialAxis(
        startAngle: 270,
        endAngle: 270,
        labelOffset: 6,
        radiusFactor: 0.75,
        maximum: 360,
        axisLineStyle: const AxisLineStyle(
          thicknessUnit: GaugeSizeUnit.factor,
          thickness: 0.1,
        ),
        interval: 9,
        canRotateLabels: true,
        axisLabelStyle: const GaugeTextStyle(fontSize: 8),
        minorTicksPerInterval: 0,
        majorTickStyle: const MajorTickStyle(
          lengthUnit: GaugeSizeUnit.factor,
          length: 0.06,
        ),
        onLabelCreated: _handleLabelCreated,
        pointers: <GaugePointer>[
          NeedlePointer(
            value: windDirection,
            needleLength: 0.5,
            needleEndWidth: 3.6,
            gradient: const LinearGradient(
              colors: <Color>[
                Color(0xFFFF6B78),
                Color(0xFFFF6B78),
                Color(0xFFE20A22),
                Color(0xFFE20A22),
              ],
              stops: <double>[0, 0.5, 0.5, 1],
            ),
            needleColor: const Color(0xFFF67280),
            knobStyle: const KnobStyle(knobRadius: 0.08, color: Colors.white),
          ),
          NeedlePointer(
            gradient: const LinearGradient(
              colors: <Color>[
                Color(0xFFE3DFDF),
                Color(0xFFE3DFDF),
                Color(0xFF7A7A7A),
                Color(0xFF7A7A7A),
              ],
              stops: <double>[0, 0.5, 0.5, 1],
            ),
            value: (windDirection + 180) % 360,
            needleLength: 0.5,
            needleEndWidth: 3.6,
            needleColor: const Color.fromARGB(240, 255, 227, 237),
            knobStyle: const KnobStyle(knobRadius: 0.08, color: Colors.white),
          ),
        ],
      ),
    ],
  );
}

void _handleLabelCreated(AxisLabelCreatedArgs args) {
  switch (args.text) {
    case '0':
    case '360':
      args.text = 'N';
      break;
    case '45':
      args.text = 'NE';
      break;
    case '90':
      args.text = 'E';
      break;
    case '135':
      args.text = 'SE';
      break;
    case '180':
      args.text = 'S';
      break;
    case '225':
      args.text = 'SW';
      break;
    case '270':
      args.text = 'W';
      break;
    case '315':
      args.text = 'NW';
      break;
    default:
      args.text = '';
  }
}

Widget humidityElevation() {
  return SfCircularChart(
    annotations: <CircularChartAnnotation>[
      CircularChartAnnotation(
          height: '100%',
          width: '100%',
          widget: PhysicalModel(
            shape: BoxShape.circle,
            elevation: 10,
            color: const Color.fromRGBO(230, 230, 230, 1),
            child: Container(),
          )),
      CircularChartAnnotation(
          widget: Text(
        '${controller.weather?.humidity ?? 0}%',
        style:
            const TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5), fontSize: 12),
      )),
    ],
    series: _getElevationDoughnutSeries(),
  );
}

List<DoughnutSeries<ChartSampleData, String>> _getElevationDoughnutSeries() {
  return <DoughnutSeries<ChartSampleData, String>>[
    DoughnutSeries<ChartSampleData, String>(
        dataSource: <ChartSampleData>[
          ChartSampleData(
            x: 'A',
            y: controller.weather?.humidity ?? 0,
            pointColor: const Color.fromRGBO(0, 220, 252, 1),
          ),
          ChartSampleData(
            x: 'B',
            y: 100 - (controller.weather?.humidity ?? 0),
            pointColor: const Color.fromRGBO(230, 230, 230, 1),
          ),
        ],
        animationDuration: 2000,
        animationDelay: 2000,
        xValueMapper: (ChartSampleData data, _) => data.x as String,
        yValueMapper: (ChartSampleData data, _) => data.y,
        pointColorMapper: (ChartSampleData data, _) => data.pointColor)
  ];
}

Widget windSpeedRange() {
  double convertToMilesPerHour(double metersPerSecond) {
    return metersPerSecond * 2.237;
  }

  double windSpeedMetersPerSecond = controller.weather?.windSpeed ?? 0;
  double windSpeedMilesPerHour =
      convertToMilesPerHour(windSpeedMetersPerSecond);

  return SfRadialGauge(
    axes: <RadialAxis>[
      RadialAxis(
        showAxisLine: false,
        showLabels: false,
        showTicks: false,
        radiusFactor: 0.75,
        startAngle: 180,
        endAngle: 360,
        maximum: 80,
        canScaleToFit: true,
        pointers: <GaugePointer>[
          NeedlePointer(
              value: controller.weather?.windSpeed ?? 0,
              needleEndWidth: 3.5,
              needleLength: 0.7,
              knobStyle: const KnobStyle())
        ],
        ranges: <GaugeRange>[
          GaugeRange(
              startValue: 0,
              endValue: 18,
              sizeUnit: GaugeSizeUnit.factor,
              startWidth: 0,
              endWidth: 0.1,
              color: const Color(0xFFA8AAE2)),
          GaugeRange(
              startValue: 20,
              endValue: 38,
              startWidth: 0.1,
              sizeUnit: GaugeSizeUnit.factor,
              endWidth: 0.15,
              color: const Color.fromRGBO(168, 170, 226, 1)),
          GaugeRange(
              startValue: 40,
              endValue: 58,
              startWidth: 0.15,
              sizeUnit: GaugeSizeUnit.factor,
              endWidth: 0.2,
              color: const Color(0xFF7B7DC7)),
          GaugeRange(
              startValue: 60,
              endValue: 78,
              startWidth: 0.2,
              sizeUnit: GaugeSizeUnit.factor,
              endWidth: 0.25,
              color: const Color.fromRGBO(73, 76, 162, 1)),
        ],
        annotations: <GaugeAnnotation>[
          GaugeAnnotation(
              angle: 90,
              positionFactor: 0.35,
              widget: Text('${windSpeedMilesPerHour.roundToDouble()} mph',
                  style: const TextStyle(
                      color: Color.fromARGB(255, 3, 57, 237), fontSize: 12))),
        ],
      ),
    ],
  );
}

Widget windPressureMonitor() {
  double pressure = controller.weather?.pressure.toDouble() ?? 0;

  return SfRadialGauge(
    axes: <RadialAxis>[
      RadialAxis(
          startAngle: 180,
          endAngle: 360,
          canScaleToFit: true,
          interval: 100,
          showLabels: false,
          radiusFactor: 0.75,
          minimum: 0,
          maximum: 1100,
          majorTickStyle: const MajorTickStyle(
              length: 0.1, lengthUnit: GaugeSizeUnit.factor),
          minorTicksPerInterval: 2,
          pointers: <GaugePointer>[
            RangePointer(
                gradient: const SweepGradient(
                    colors: <Color>[Color(0xFFD481FF), Color(0xFF06F0E0)],
                    stops: <double>[0.25, 0.75]),
                value: pressure,
                width: 4,
                animationDuration: 2000,
                enableAnimation: true,
                animationType: AnimationType.elasticOut,
                color: const Color(0xFF00A8B5)),
            NeedlePointer(
                value: pressure,
                needleStartWidth: 0,
                needleColor: const Color(0xFFD481FF),
                needleLength: 1,
                enableAnimation: true,
                animationDuration: 2000,
                animationType: AnimationType.elasticOut,
                needleEndWidth: 4,
                knobStyle: const KnobStyle(knobRadius: 0))
          ],
          minorTickStyle: const MinorTickStyle(
              length: 0.03, lengthUnit: GaugeSizeUnit.factor),
          axisLineStyle: const AxisLineStyle(color: Colors.transparent))
    ],
  );
}

Widget sunSetRiseMonitor() {
  DateTime sunriseDateTime = DateTime.fromMillisecondsSinceEpoch(
    (controller.weather?.sunrise ?? 0) * 1000,
  );
  DateTime sunsetDateTime = DateTime.fromMillisecondsSinceEpoch(
    (controller.weather?.sunset ?? 0) * 1000,
  );

  int sunriseHour = sunriseDateTime.hour;
 
  int sunsetHour = sunsetDateTime.hour;
  

  return SfRadialGauge(
    
    enableLoadingAnimation: true,
    axes: <RadialAxis>[
      RadialAxis(
        maximum: 24.01,
        interval: 2.0,
        radiusFactor: 0.75,
        labelOffset: 6,
        axisLabelStyle: const GaugeTextStyle(fontSize: 7.5),
        majorTickStyle:
            const MajorTickStyle(length: 0.1, lengthUnit: GaugeSizeUnit.factor),
        minorTickStyle: const MinorTickStyle(
            length: 0.1, lengthUnit: GaugeSizeUnit.factor, thickness: 1.0),
        
        pointers: <GaugePointer>[
          MarkerPointer(
            color: Colors.green,
            value: sunriseHour.toDouble(),
            markerOffset: -12,
            markerHeight: 12,
            markerWidth: 12,
          ),
          MarkerPointer(
            color: Colors.red,
            value: sunsetHour.toDouble(),
            markerOffset: -12,
            markerHeight: 12,
            markerWidth: 12,
          )
        ],
        axisLineStyle: const AxisLineStyle(
          gradient: SweepGradient(
            colors: <Color>[
              Colors.green,
              Colors.red,
            ],
            stops: <double>[0.35, 0.85],
          ),
          thickness: 6,
        ),
      ),
    ],
  );
}

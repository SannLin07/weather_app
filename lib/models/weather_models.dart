class Weather {
  final String cityName;
  final String main;
  final String description;
  final String icon;
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final double windSpeed;
  final double windDeg;
  final int sunrise;
  final int sunset;

  Weather({
    required this.cityName,
    required this.main,
    required this.description,
    required this.icon,
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.windDeg,
    required this.sunrise,
    required this.sunset,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
  return Weather(
    cityName: json['name'] ?? '',
    main: json['weather'][0]['main'] ?? '',
    description: json['weather'][0]['description'] ?? '',
    icon: json['weather'][0]['icon'] ?? '',
    temp: (json['main']['temp'] ?? 0).toDouble(),
    feelsLike: (json['main']['feels_like'] ?? 0).toDouble(),
    tempMin: (json['main']['temp_min'] ?? 0).toDouble(),
    tempMax: (json['main']['temp_max'] ?? 0).toDouble(),
    pressure: json['main']['pressure'] ?? 0,
    humidity: json['main']['humidity'] ?? 0,
    windSpeed: (json['wind']['speed'] ?? 0).toDouble(),
    windDeg: (json['wind']['deg'] ?? 0).toDouble(),
    sunrise: json['sys']['sunrise'] ?? 0,
    sunset: json['sys']['sunset'] ?? 0,
  );
}

}

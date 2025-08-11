// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../domain/models/weather.dart';

class ApiWeather {
  final String cityName;
  final double temperature;
  final double wind;
  final int humidity;
  final String condition;
  final String iconUrl;

  ApiWeather({
    required this.cityName,
    required this.temperature,
    required this.wind,
    required this.humidity,
    required this.condition,
    required this.iconUrl,
  });

  factory ApiWeather.fromJson(Map<String, dynamic> json) {
    return ApiWeather(
      cityName: json['location']['name'],
      temperature: (json['current']['temp_c'] as num).toDouble(),
      condition: json['current']['condition']['text'],
      wind: (json['current']['wind_kph'] as num).toDouble(),
      humidity: json['current']['humidity'] as int,
      iconUrl: 'https:${json['current']['condition']['icon']}',
    );
  }

  Weather toDomain() {
    return Weather(
      cityName: cityName,
      temperature: temperature,
      condition: condition,
      iconUrl: iconUrl,
      humidity: humidity,
      wind: wind,
    );
  }
}

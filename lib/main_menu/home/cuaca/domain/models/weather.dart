// ignore_for_file: public_member_api_docs, sort_constructors_first
class Weather {
  final String cityName;
  final double temperature;
  final String condition;
  final int humidity;
  final double wind;
  final String iconUrl;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.humidity,
    required this.wind,
    required this.iconUrl,
  });
}

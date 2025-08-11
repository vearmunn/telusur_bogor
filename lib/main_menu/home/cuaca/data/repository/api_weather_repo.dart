import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../domain/models/weather.dart';
import '../../domain/repository/weather_repo.dart';
import '../models/api_weather.dart';

class ApiWeatherRepo implements WeatherRepo {
  final String apiKey = 'aafd3cdc14194e38b6d42001251008';
  final String baseUrl = 'http://api.weatherapi.com/v1';

  @override
  Future<Weather> getCurrentWeather() async {
    final url = Uri.parse('$baseUrl/current.json?key=$apiKey&q=bogor&lang=jv');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ApiWeather.fromJson(data).toDomain();
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}

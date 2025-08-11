import '../models/weather.dart';

abstract class WeatherRepo {
  Future<Weather> getCurrentWeather();
}

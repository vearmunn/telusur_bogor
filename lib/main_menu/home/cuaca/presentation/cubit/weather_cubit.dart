import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telusur_bogor/main_menu/home/cuaca/data/repository/api_weather_repo.dart';

import '../../domain/models/weather.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final ApiWeatherRepo apiWeatherRepo;

  WeatherCubit(this.apiWeatherRepo) : super(WeatherInitial()) {
    fetchCurrentWeather();
  }

  Future fetchCurrentWeather() async {
    emit(WeatherLoading());
    try {
      final weather = await apiWeatherRepo.getCurrentWeather();
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:weatherapp/domain/entities/weather.dart';
import 'package:weatherapp/domain/repositories/weather_repository.dart';

class SaveWeatherUseCase  {
  final WeatherRepository _weatherRepository;

  SaveWeatherUseCase(this._weatherRepository);

  Future<void> execute(Weather weather) {
    return _weatherRepository.saveWeather(weather);
  }

}

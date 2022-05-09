import 'package:dartz/dartz.dart';
import 'package:weatherapp/data/failure.dart';
import 'package:weatherapp/domain/entities/weather.dart';

abstract class WeatherRepository {
  // API methods
  Future<Either<Failure, Weather>> getCurrentWeather(String cityName);

// Database methods
  Future<List<Weather>> getSavedWeather();

  Future<void> saveWeather(Weather weather);

  Future<void> removeWeather(Weather weather);

}

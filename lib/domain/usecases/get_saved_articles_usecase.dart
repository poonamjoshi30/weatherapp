import 'package:dartz/dartz.dart';
import 'package:weatherapp/core/usecase/usecase.dart';
import 'package:weatherapp/domain/entities/weather.dart';
import 'package:weatherapp/domain/repositories/weather_repository.dart';

import '../../data/failure.dart';



class GetSavedWeatherUseCase  {
  final WeatherRepository _weatherRepository;

  GetSavedWeatherUseCase(this._weatherRepository);

    Future<List<Weather>> execute() {
    return _weatherRepository.getSavedWeather();
  }

}

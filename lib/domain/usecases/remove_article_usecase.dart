import 'package:weatherapp/domain/entities/weather.dart';
import 'package:weatherapp/domain/repositories/weather_repository.dart';

import '../../core/usecase/usecase.dart';

class RemoveWeatherUseCase {
  final WeatherRepository _weatherRepository;


  RemoveWeatherUseCase(this._weatherRepository);

  Future<void> execute(Weather weather) {
    return _weatherRepository.removeWeather(weather);
  }

}



import 'package:equatable/equatable.dart';
import 'package:weatherapp/domain/entities/weather.dart';

abstract class LocalWeatherEvent extends Equatable {

  const LocalWeatherEvent();

  @override
  List<Object?> get props => [];
}

class GetAllSavedWeather extends LocalWeatherEvent {
  const GetAllSavedWeather();
}

class RemoveWeather extends LocalWeatherEvent {
  final Weather weather;

  RemoveWeather(this.weather);

  @override
  List<Object?> get props => [weather];
  // const RemoveWeather(Weather weather) : super(weather: weather);
}

class SaveWeather extends LocalWeatherEvent {
  final Weather weather;

  SaveWeather(this.weather);

  @override
  List<Object?> get props => [weather];
  // const SaveWeather(Weather weather) : super(weather: weather);
}

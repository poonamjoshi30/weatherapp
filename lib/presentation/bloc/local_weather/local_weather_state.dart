

import 'package:equatable/equatable.dart';
import 'package:weatherapp/domain/entities/weather.dart';

abstract class LocalWeatherState extends Equatable {

  const LocalWeatherState();

  @override
  List<Object?> get props => [];
}

class LocalWeatherLoading extends LocalWeatherState {
  const LocalWeatherLoading();
}
class LocalWeatherError extends LocalWeatherState {
  final String message;

  LocalWeatherError(this.message);

  @override
  List<Object?> get props => [message];
}
class LocalWeatherDone extends LocalWeatherState {
  final List<Weather> weather;

  LocalWeatherDone(this.weather);

  @override
  List<Object?> get props => [weather];

}

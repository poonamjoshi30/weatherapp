import 'package:floor/floor.dart';
import 'package:weatherapp/domain/entities/weather.dart';

import 'package:weatherapp/core/utils/constants.dart';

@dao
abstract class WeatherDao {
  @Query('SELECT * FROM $kWeatherTableName')
  Future<List<Weather>> getAllWeather();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertWeather(Weather weather);

  @delete
  Future<void> deleteWeather(Weather weather);
}
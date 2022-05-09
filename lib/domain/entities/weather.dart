import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../../core/utils/constants.dart';
@Entity(tableName: kWeatherTableName)
class Weather extends Equatable {
  const Weather({
    required this.id,
    required this.cityName,
    required this.main,
    required this.description,
    required this.iconCode,
    required this.temperature,
    required this.pressure,
    required this.humidity,
  });
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String cityName;
  final String main;
  final String description;
  final String iconCode;
  final double temperature;
  final int pressure;
  final int humidity;

  @override
  List<Object?> get props => [
        cityName,
        main,
        description,
        iconCode,
        temperature,
        pressure,
        humidity,
      ];
}

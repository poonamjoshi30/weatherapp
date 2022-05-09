import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:weatherapp/data/datasources/local/DAOs/weather_dao.dart';

import '../../../domain/entities/weather.dart';
import 'DAOs/weather_dao.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [Weather])
abstract class AppDatabase extends FloorDatabase {
  WeatherDao get weatherDao;
}

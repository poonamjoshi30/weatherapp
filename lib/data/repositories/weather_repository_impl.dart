import 'dart:io';

import 'package:weatherapp/data/datasources/local/app_database.dart';
import 'package:weatherapp/data/datasources/remote_data_source.dart';
import 'package:weatherapp/data/exception.dart';
import 'package:weatherapp/domain/entities/weather.dart';
import 'package:weatherapp/data/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:weatherapp/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final RemoteDataSource remoteDataSource;
  final AppDatabase appDatabase;

  WeatherRepositoryImpl({required this.remoteDataSource,required this.appDatabase});

  @override
  Future<Either<Failure, Weather>> getCurrentWeather(String cityName) async {
    try {
      final result = await remoteDataSource.getCurrentWeather(cityName);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }




  @override
  Future<List<Weather>> getSavedWeather() async{
    return appDatabase.weatherDao.getAllWeather();
  }

  @override
  Future<void> removeWeather(Weather weather) async{
    return appDatabase.weatherDao.deleteWeather(weather);
  }

  @override
  Future<void> saveWeather(Weather weather) async{
    return appDatabase.weatherDao.insertWeather(weather);
  }



}

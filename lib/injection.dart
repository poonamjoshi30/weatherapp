import 'package:get_it/get_it.dart';

import 'data/repositories/weather_repository_impl.dart';
import 'domain/repositories/weather_repository.dart';

import 'package:weatherapp/data/datasources/remote_data_source.dart';
import 'package:weatherapp/domain/usecases/get_current_weather.dart';
import 'package:weatherapp/domain/usecases/get_saved_articles_usecase.dart';
import 'package:weatherapp/domain/usecases/remove_article_usecase.dart';
import 'package:weatherapp/presentation/bloc/local_weather/local_weather_bloc.dart';
import 'package:weatherapp/presentation/bloc/remote_weather/weather_bloc.dart';
import 'package:http/http.dart' as http;


import 'core/utils/constants.dart';
import 'data/datasources/local/app_database.dart';
import 'domain/usecases/save_weather_usecase.dart';

GetIt locator = GetIt.instance;

 Future<void> init() async {
  // *
  final database = await $FloorAppDatabase.databaseBuilder(kDatabaseName).build();
  locator.registerSingleton<AppDatabase>(database);

  // bloc
  locator.registerFactory(() => WeatherBloc(locator()));

  // usecase
  locator.registerLazySingleton(() => GetCurrentWeather(locator()));

  // *
  locator.registerLazySingleton(() => GetSavedWeatherUseCase(locator()));
  locator.registerLazySingleton(() => SaveWeatherUseCase(locator()));
  locator.registerLazySingleton(() => RemoveWeatherUseCase(locator()));

  // repository
  locator.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      remoteDataSource: locator(),appDatabase: database
    ),
  );


  // data source
  locator.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(
      client: locator(),
    ),
  );


// *
   locator.registerLazySingleton<LocalWeatherBloc>(
         () => LocalWeatherBloc(locator(), locator(), locator()),
   );
  // external
  locator.registerLazySingleton(() => http.Client());
}

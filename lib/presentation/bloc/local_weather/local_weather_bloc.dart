import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weatherapp/domain/usecases/get_saved_articles_usecase.dart';
import 'package:weatherapp/domain/usecases/save_weather_usecase.dart';
import 'package:weatherapp/presentation/bloc/local_weather/local_weather_event.dart';
import 'package:weatherapp/presentation/bloc/local_weather/local_weather_state.dart';

import '../../../domain/usecases/remove_article_usecase.dart';





class LocalWeatherBloc extends Bloc<LocalWeatherEvent, LocalWeatherState> {
  final GetSavedWeatherUseCase _getSavedWeatherUseCase;
  final SaveWeatherUseCase _saveWeatherUseCase;
  final RemoveWeatherUseCase _removeWeatherUseCase;

  LocalWeatherBloc(this._getSavedWeatherUseCase,
      this._saveWeatherUseCase,
      this._removeWeatherUseCase,) : super(LocalWeatherLoading()) {
    on<GetAllSavedWeather>(
          (event, emit) async {


        emit(LocalWeatherLoading());
        // _getAllSavedWeather();
        final result = await _getSavedWeatherUseCase.execute();// as List<Weather>;
        if(result.isEmpty){
          emit(LocalWeatherError("No Data Found"));
        }else {
          emit(LocalWeatherDone(result));
        }

      },
      transformer: debounce(Duration(milliseconds: 500)),
    );
    on<SaveWeather>(
          (event, emit) async {
        final weather = event.weather;

        emit(LocalWeatherLoading());

        final result = await _saveWeatherUseCase.execute(weather);


      },
      transformer: debounce(Duration(milliseconds: 500)),
    );
    on<RemoveWeather>(
          (event, emit) async {
        final weather = event.weather;

        emit(LocalWeatherLoading());

        final result = await _removeWeatherUseCase.execute(weather);

        final resultsavedata = await _getSavedWeatherUseCase.execute();// as List<Weather>;
        if(resultsavedata.isEmpty){
          emit(LocalWeatherError("No Data Found"));
        }else {
          emit(LocalWeatherDone(resultsavedata));
        }
      },
      transformer: debounce(Duration(milliseconds: 500)),
    );
  }
  Stream<LocalWeatherState> _getAllSavedWeather() async*{
    final result = await _getSavedWeatherUseCase.execute();// as List<Weather>;
    if(result.isEmpty){
      yield(LocalWeatherError("No Data Found"));
    }else {
      yield LocalWeatherDone(result);
    }
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

}

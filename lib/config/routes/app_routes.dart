import 'package:flutter/material.dart';
import 'package:weatherapp/presentation/pages/local_weather_page.dart';
import 'package:weatherapp/presentation/pages/weather_page.dart';



class AppRoutes {
  static Route? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const WeatherPage());
        break;
        case '/SavedWeatherView':
        return _materialRoute(const LocalWeatherPage());
        break;
      default:
        return null;
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}

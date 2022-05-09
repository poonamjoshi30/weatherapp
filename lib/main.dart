import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/config/routes/app_routes.dart';
import 'package:weatherapp/presentation/bloc/remote_weather/weather_bloc.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'injection.dart' as di;
import 'presentation/bloc/local_weather/local_weather_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  runApp(MyApp(savedThemeMode: savedThemeMode));



  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;
  const MyApp({Key? key, this.savedThemeMode}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return AdaptiveTheme(
        light: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepPurple,
        ),
        dark: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.black,
        ),
        initial: savedThemeMode ?? AdaptiveThemeMode.light,
        builder: (theme, darkTheme) => MultiBlocProvider(providers: [
          BlocProvider<WeatherBloc>(
            create: (BuildContext context) => di.locator<WeatherBloc>(),
          ),
          BlocProvider<LocalWeatherBloc>(
            create: (BuildContext context) =>di.locator<LocalWeatherBloc>(),
          )
        ]
          , child:MaterialApp(
            debugShowCheckedModeBanner: false,
            title:'Weather',
            onGenerateRoute: AppRoutes.onGenerateRoutes,
            theme: theme,
            darkTheme: darkTheme,
          ),
        )

    );
  }

  }


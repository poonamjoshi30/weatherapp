import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/data/constants.dart';
import 'package:weatherapp/presentation/bloc/local_weather/local_weather_bloc.dart';
import 'package:weatherapp/presentation/bloc/local_weather/local_weather_event.dart';
import 'package:weatherapp/presentation/bloc/remote_weather/weather_bloc.dart';
import 'package:weatherapp/presentation/bloc/remote_weather/weather_event.dart';
import 'package:weatherapp/presentation/bloc/remote_weather/weather_state.dart';
class WeatherPage extends StatelessWidget {

  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            "Weather",
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/SavedWeatherView');
            },
          ),
      IconButton(
            icon: Icon(
              Icons.settings_display,
              color: Colors.white,
            ),
            onPressed: () {
             // AdaptiveTheme.of(context).toggleThemeMode(); double click required
            (AdaptiveTheme.of(context).mode==AdaptiveThemeMode.dark)?
               AdaptiveTheme.of(context).setLight():
               AdaptiveTheme.of(context).setDark();

            },
          )
        ],
      ),
     body: Padding(
       padding: const EdgeInsets.all(10.0),
       child: Column(
         children: [
          TextField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: 'Enter city name',
            ),
            onChanged: (query) {

             context.read<WeatherBloc>().add(OnCityChanged(query));
            },
          ),
           const SizedBox(height: 32.0),
           BlocBuilder<WeatherBloc, WeatherState>(
             builder: (context, state) {
               if (state is WeatherLoading) {
                 return Center(
                   child: CircularProgressIndicator(),
                 );
               } else if (state is WeatherHasData) {
                 return Container(
                   padding: EdgeInsets.fromLTRB(10,10,10,10),
                     decoration: BoxDecoration(
                         border: Border.all(
                           color: Colors.grey,  // red as border color
                         ),
                         borderRadius: BorderRadius.circular(10.0)
                     ),
                     child:Column(
                   key: Key('weather_data'),
                   children: [
                     Row(

                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [

                         Text(
                           state.result.cityName,
                           style: TextStyle(
                             fontSize: 22.0,
                           ),
                         ),
                         Image(
                           image: NetworkImage(
                             Urls.weatherIcon(
                               state.result.iconCode,
                             ),
                           ),
                         ),

                       ],
                     ),
                     SizedBox(height: 8.0),
                     Text(
                       '${state.result.main} | ${state.result.description}',
                       style: TextStyle(
                         fontSize: 16.0,
                         letterSpacing: 1.2,
                       ),
                     ),
                     SizedBox(height: 24.0),
                     Table(

                       defaultColumnWidth: FixedColumnWidth(150.0),
                       border: TableBorder.all(
                         color: Colors.grey,
                         style: BorderStyle.solid,
                         width: 1,
                       ),
                       children: [
                         TableRow(children: [
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Text(
                               'Temperature',
                               style: TextStyle(
                                 fontSize: 16.0,
                                 letterSpacing: 1.2,
                               ),
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Text(
                               state.result.temperature.toString(),
                               style: TextStyle(
                                 fontSize: 16.0,
                                 letterSpacing: 1.2,
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                           ), // Will be change later
                         ]),
                         TableRow(children: [
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Text(
                               'Pressure',
                               style: TextStyle(
                                 fontSize: 16.0,
                                 letterSpacing: 1.2,
                               ),
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Text(
                               state.result.pressure.toString(),
                               style: TextStyle(
                                   fontSize: 16.0,
                                   letterSpacing: 1.2,
                                   fontWeight: FontWeight.bold),
                             ),
                           ), // Will be change later
                         ]),
                         TableRow(children: [
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Text(
                               'Humidity',
                               style: TextStyle(
                                 fontSize: 16.0,
                                 letterSpacing: 1.2,
                               ),
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Text(
                               state.result.humidity.toString(),
                               style: TextStyle(
                                 fontSize: 16.0,
                                 letterSpacing: 1.2,
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                           ), // Will be change later
                         ]),
                       ],
                     ),

                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: ElevatedButton(
                           onPressed: (){

                             context.read<LocalWeatherBloc>().add(SaveWeather(state.result));
                             // SaveWeather(state.result);
                             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                               content: Text("Saved Successfully"),
                               backgroundColor: Colors.black,
                             ));
                             } , child: Text('Save',
                         style: TextStyle(color: Colors.white),
                       ),
                       ),
                     )
                   ],
                 )
                 );
               } else if (state is WeatherError) {
                 return Center(
                   child: Text('Something went wrong!'),
                 );
               } else {
                 return SizedBox();
               }
             },
           ),

         ],
       ),
     ),
    );

  }
  // void _onRemove() {
  //   if (onRemove != null) {
  //     onRemove(weather);
  //   }
  // }
  // void _onSave() {
  //   if (onSave != null) {
  //     onSave(weather);
  //   }
  // }
}

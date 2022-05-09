import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/data/constants.dart';
import 'package:weatherapp/presentation/bloc/local_weather/local_weather_bloc.dart';
import 'package:weatherapp/presentation/bloc/local_weather/local_weather_event.dart';
import 'package:weatherapp/presentation/bloc/local_weather/local_weather_state.dart';
class LocalWeatherPage extends StatefulWidget {

  const LocalWeatherPage({Key? key}) : super(key: key);

  @override
  State<LocalWeatherPage> createState() => _LocalWeatherPageState();
}

class _LocalWeatherPageState extends State<LocalWeatherPage> {

  @override
  Widget build(BuildContext context) {
    context.read<LocalWeatherBloc>().add(GetAllSavedWeather());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather List",
          style: TextStyle(color: Colors.white),
        ),


      ),
      body:  Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Stack(
              children: <Widget>[
        Column(
          children: [

            const SizedBox(height: 20.0),
            BlocBuilder<LocalWeatherBloc, LocalWeatherState>(
              builder: (context, state) {

                if (state is LocalWeatherLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LocalWeatherDone) {

                    return Column(
                        children:  List.generate(
                        state.weather.length,
                    (index) =>  Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey, // red as border color
                            ),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Dismissible(
                            key: UniqueKey(),
                            direction: DismissDirection.horizontal,
                            confirmDismiss: (DismissDirection direction) async {
                              return await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Confirm"),
                                    content: const Text("Are you sure you want to delete this item?"),
                                    actions: <Widget>[

                                  TextButton(
                                  style: TextButton.styleFrom(
                                  padding: const EdgeInsets.all(16.0),
                                      ), onPressed: () {
                                    print(state.weather[index].id);
                                    context.read<LocalWeatherBloc>().add(RemoveWeather(state.weather[index]));
                                    Navigator.of(context).pop(true);
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text("Removed Successfully"),
                                      backgroundColor: Colors.black,
                                    ));
                                    setState(() {});
                                   },
                                  child: const Text('DELETE'),

                                      ),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                            padding: const EdgeInsets.all(16.0)

                                        ), onPressed: () { Navigator.of(context).pop(false); },
                                        child: const Text('CANCEL'),
                                      )

                                    ],
                                  );
                                },
                              );
                            },
                            onDismissed: (direction) {
                            },
                            background: Container(

                                alignment: AlignmentDirectional.centerEnd,
                                color: Colors.red,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Container(

                                      padding: EdgeInsets.fromLTRB(0.0, 0.0, 10, 0.0),
                                      child:  IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {

                                        },
                                      ),
                                    ),

                                  ],
                                )),
                           child: Column(
                          key: Key('weather_data'),
                          children: [


      Row(

        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Text(
            state.weather[index].cityName,
            style: TextStyle(
              fontSize: 22.0,
            ),
          ),
          Image(
            image: NetworkImage(
              Urls.weatherIcon(
                state.weather[index].iconCode,
              ),
            ),
          ),

        ],
      ),
      SizedBox(height: 8.0),
      Text(
        '${state.weather[index].main} | ${state.weather[index].description}',
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
                state.weather[index].temperature.toString(),
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
                state.weather[index].pressure.toString(),
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
                state.weather[index].humidity.toString(),
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

                          ],
                        )
                    )

                        )

                    ));

                }else if (state is LocalWeatherError) {
    return Center(
    child: Text('No Data Found'),
    ); }
              else {
                  return SizedBox();
                }
              },
            ),

          ],
        ),
     ]
    ),
    ),
    ),
    );

  }
}

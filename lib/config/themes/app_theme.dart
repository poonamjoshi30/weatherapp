import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: Colors.deepPurple,
      ),
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.white,
      primaryColorBrightness: Brightness.light,
      brightness: Brightness.light,
      primaryColorDark: Colors.black,
      canvasColor: Colors.white,
      splashColor: Colors.transparent,
      fontFamily: 'IBM',
    );
  }
  static ThemeData get Dark {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: Colors.deepPurple,
      ),
      scaffoldBackgroundColor: Colors.black,

      accentColor: Colors.white,
      splashColor: Colors.transparent,
      primaryColor: Colors.black,
      primaryColorBrightness: Brightness.dark,
      primaryColorLight: Colors.black,
      brightness: Brightness.dark,
      primaryColorDark: Colors.black,
      indicatorColor: Colors.white,
      canvasColor: Colors.black,
      fontFamily: 'IBM',
    );
  }
}

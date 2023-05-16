import 'package:flutter/material.dart';

class MyTheme {
  static get lightTheme {
    return ThemeData(
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          color: accentColor,
        ),
        headlineMedium: TextStyle(
          color: accentColor,
          fontSize: 25,
          fontWeight: FontWeight.w300,
          height: 1.5,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color?>(Colors.transparent),
          foregroundColor: MaterialStateProperty.all<Color?>(accentColor),
          elevation: MaterialStateProperty.all<double?>(0),
          minimumSize: MaterialStateProperty.all<Size>(const Size(150, 40)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(
                width: 1.5,
                color: accentColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static get darkTheme {
    return ThemeData();
  }
}

Color accentColor = Color.fromARGB(255, 37, 72, 113);

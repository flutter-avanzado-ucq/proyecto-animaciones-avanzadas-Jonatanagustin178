import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.deepPurple,
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(bodyLarge: TextStyle(color: Colors.black87)),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.deepPurple,
    scaffoldBackgroundColor: Colors.black,
    textTheme: const TextTheme(bodyLarge: TextStyle(color: Colors.white)),
  );
}

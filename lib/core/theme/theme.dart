import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
  scaffoldBackgroundColor: Color.fromRGBO(255, 253, 252, 1),
  iconTheme: IconThemeData(color: const Color.fromARGB(255, 220, 123, 4)),
  textTheme: TextTheme(
    titleLarge: TextStyle(
      color: Color.fromRGBO(19, 19, 19, 1),
      fontSize: 25,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      color: Color.fromRGBO(19, 19, 19, 1),
      fontSize: 15,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(color: Color.fromRGBO(64, 68, 67, 1.0), fontSize: 12),
  ),
  colorScheme: ColorScheme.light(
    primary: const Color.fromARGB(255, 220, 123, 4),
    secondary: Color.fromRGBO(233, 233, 233, 1),
    tertiary: Color.fromRGBO(64, 68, 67, 1.0),
    outline: Color.fromRGBO(0, 136, 204, 1.0),
    error: Color.fromRGBO(255, 0, 0, 1.0),
  ),
);

import 'package:flutter/material.dart';

ThemeData brightTheme = ThemeData(
  primaryColor: const Color(0xFF880E4F),
  accentColor: const Color(0xFF880E4F),
  scaffoldBackgroundColor: const Color.fromARGB(255, 214, 214, 214),
  textTheme: const TextTheme(
    headline1: TextStyle(color: Colors.black),
    headline2: TextStyle(color: Colors.black),
    bodyText2: TextStyle(color: Colors.black),
    subtitle1: TextStyle(color: Colors.black),
    bodyText1: TextStyle(color: Colors.black),
  ),
  iconTheme: IconThemeData(color: Colors.black),
);

ThemeData darkTheme = ThemeData(
  primaryColor: const Color(0xFFB80564),
  accentColor: const Color(0xFFB80564),
  scaffoldBackgroundColor: const Color.fromARGB(255, 48, 48, 48),
  textTheme: const TextTheme(
    headline1: TextStyle(color: Colors.white),
    headline2: TextStyle(color: Colors.white),
    bodyText2: TextStyle(color: Colors.white),
    subtitle1: TextStyle(color: Colors.white),
    bodyText1: TextStyle(color: Colors.white),
  ),
  iconTheme: IconThemeData(color: Colors.white),
);

import 'package:flutter/material.dart';

// Define theme colors
const Color primaryYellow = Color(0xFFF5DF4D);
const Color lightText = Colors.black;
const Color lightBackground = Colors.white;

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: primaryYellow,
  scaffoldBackgroundColor: lightBackground,
  fontFamily: 'Poppins',
  useMaterial3: true,
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontWeight: FontWeight.bold, color: lightText),
    headlineSmall: TextStyle(fontWeight: FontWeight.bold, color: lightText),
    titleMedium: TextStyle(fontWeight: FontWeight.bold, color: lightText),
    bodyMedium: TextStyle(color: Colors.black54),
    labelLarge: TextStyle(fontWeight: FontWeight.bold, color: lightText),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: lightBackground,
    foregroundColor: lightText,
    elevation: 0,
    iconTheme: IconThemeData(color: lightText),
    titleTextStyle: TextStyle(
      fontFamily: 'FlockFont',
      fontSize: 32.0,
      color: lightText,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0),
      borderSide: const BorderSide(color: lightText),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0),
      borderSide: const BorderSide(color: lightText, width: 2.0),
    ),
    labelStyle: const TextStyle(color: Colors.black54),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: const StadiumBorder(),
      backgroundColor: primaryYellow,
      foregroundColor: lightText,
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins',
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: const StadiumBorder(),
      foregroundColor: lightText,
      side: const BorderSide(color: lightText, width: 2),
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins',
      ),
    ),
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(iconColor: WidgetStatePropertyAll(lightText)),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.black,
      textStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins',
      ),
    ),
  ),
);

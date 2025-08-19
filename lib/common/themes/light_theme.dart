import 'package:flutter/material.dart';

// Define theme colors
const Color primaryYellow = Color(0xFFFFC549);
const Color secondaryTomato = Color(0xffef6a3f);
const Color lightText = Colors.black;
const Color lightBackground = Color(0xFFfbfbfb);

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
    fillColor: Colors.grey.shade800,
    enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
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
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color:
        primaryYellow, // Overrides the colorScheme.primary for circular indicators
    circularTrackColor:
        primaryYellow, // Sets the track color for circular indicators
  ),
);

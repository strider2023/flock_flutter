import 'package:flutter/material.dart';

// Define theme colors
const Color primaryYellow = Color(0xFFFFC549);
const Color darkText = Colors.white;
const Color lightText = Colors.black; // For text on yellow buttons
const Color darkBackground = Color(0xFF232122);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: primaryYellow,
  scaffoldBackgroundColor: darkBackground,
  fontFamily: 'Poppins',
  useMaterial3: true,
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontWeight: FontWeight.bold, color: darkText),
    headlineSmall: TextStyle(fontWeight: FontWeight.bold, color: darkText),
    titleMedium: TextStyle(fontWeight: FontWeight.bold, color: darkText),
    bodyMedium: TextStyle(color: Colors.white70),
    labelLarge: TextStyle(fontWeight: FontWeight.bold, color: lightText),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: darkBackground,
    foregroundColor: darkText,
    elevation: 0,
    iconTheme: IconThemeData(color: primaryYellow),
    titleTextStyle: TextStyle(
      fontFamily: 'FlockFont',
      fontSize: 32.0,
      color: darkText,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.grey.shade800,
    enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
    labelStyle: const TextStyle(color: Colors.white70),
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
      foregroundColor: darkText,
      side: const BorderSide(color: darkText, width: 2),
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins',
      ),
    ),
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(iconColor: WidgetStatePropertyAll(darkText)),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: primaryYellow,
      textStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins',
      ),
    ),
  ),
  navigationBarTheme: NavigationBarThemeData(
    indicatorColor: primaryYellow,
    iconTheme: WidgetStateProperty.all(
      const IconThemeData(color: Colors.white),
    ),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color:
        primaryYellow, // Overrides the colorScheme.primary for circular indicators
    circularTrackColor:
        primaryYellow, // Sets the track color for circular indicators
  ),
);

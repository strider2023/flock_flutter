import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Define theme colors
const Color primaryYellow = Color(0xFFFFC549);
const Color darkText = Colors.white;
const Color lightText = Colors.black; // For text on yellow buttons
const Color darkBackground = Color(0xFF232122);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: primaryYellow,
  scaffoldBackgroundColor: darkBackground,
  fontFamily: GoogleFonts.lexend().fontFamily,
  useMaterial3: true,
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontWeight: FontWeight.bold,
      color: darkText,
      fontFamily: GoogleFonts.lexend().fontFamily,
    ),
    headlineSmall: TextStyle(
      fontWeight: FontWeight.bold,
      color: darkText,
      fontFamily: GoogleFonts.lexend().fontFamily,
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.bold,
      color: darkText,
      fontFamily: GoogleFonts.lexend().fontFamily,
    ),
    bodyMedium: TextStyle(
      color: darkText,
      fontFamily: GoogleFonts.lexend().fontFamily,
    ),
    labelLarge: TextStyle(
      fontWeight: FontWeight.bold,
      color: darkText,
      fontFamily: GoogleFonts.lexend().fontFamily,
    ),
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
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: GoogleFonts.lexend().fontFamily,
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: const StadiumBorder(),
      foregroundColor: darkText,
      side: const BorderSide(color: darkText, width: 2),
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: GoogleFonts.lexend().fontFamily,
      ),
    ),
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(iconColor: WidgetStatePropertyAll(darkText)),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: primaryYellow,
      textStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: GoogleFonts.lexend().fontFamily,
      ),
    ),
  ),
  navigationBarTheme: NavigationBarThemeData(
    indicatorColor: primaryYellow,
    backgroundColor: Color(0xff323f76),
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
  cardTheme: CardThemeData(
    color: Colors.blueGrey[800],
    clipBehavior: Clip.antiAlias,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
  ),
  chipTheme: ChipThemeData(
    shape: const StadiumBorder(),
    backgroundColor: primaryYellow,
    selectedColor: primaryYellow,
    labelStyle: const TextStyle(color: Colors.black, fontSize: 16.0),
    padding: const EdgeInsets.all(8.0),
    elevation: 4.0,
    side: BorderSide.none,
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: darkBackground,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    elevation: 5.0,
    showDragHandle: true,
  ),
);

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Define theme colors
const Color primaryYellow = Color(0xFFFFC549);
const Color secondaryTomato = Color(0xffef6a3f);
const Color lightText = Color(0xFF232122);
const Color lightBackground = Color(0xFFfbfbfb);

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: primaryYellow,
  scaffoldBackgroundColor: lightBackground,
  fontFamily: GoogleFonts.lexend().fontFamily,
  useMaterial3: true,
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontWeight: FontWeight.bold,
      color: lightText,
      fontFamily: GoogleFonts.lexend().fontFamily,
    ),
    headlineSmall: TextStyle(
      fontWeight: FontWeight.bold,
      color: lightText,
      fontFamily: GoogleFonts.lexend().fontFamily,
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.bold,
      color: lightText,
      fontFamily: GoogleFonts.lexend().fontFamily,
    ),
    bodyMedium: TextStyle(
      color: Colors.black54,
      fontFamily: GoogleFonts.lexend().fontFamily,
    ),
    labelLarge: TextStyle(
      fontWeight: FontWeight.bold,
      color: lightText,
      fontFamily: GoogleFonts.lexend().fontFamily,
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: lightBackground,
    foregroundColor: lightText,
    elevation: 0,
    iconTheme: const IconThemeData(color: lightText),
    titleTextStyle: GoogleFonts.tinos(
      fontSize: 32,
      fontWeight: FontWeight.bold,
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
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: GoogleFonts.lexend().fontFamily,
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: const StadiumBorder(),
      foregroundColor: lightText,
      side: const BorderSide(color: lightText, width: 2),
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: GoogleFonts.lexend().fontFamily,
      ),
    ),
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(iconColor: WidgetStatePropertyAll(lightText)),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.black,
      textStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: GoogleFonts.lexend().fontFamily,
      ),
    ),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: primaryYellow,
    circularTrackColor: primaryYellow,
  ),
  cardTheme: CardThemeData(
    color: Color(0xffe6e8e7),
    clipBehavior: Clip.antiAlias,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
  ),
  chipTheme: ChipThemeData(
    shape: const StadiumBorder(),
    backgroundColor: primaryYellow,
    labelStyle: const TextStyle(color: Colors.black, fontSize: 16.0),
    padding: const EdgeInsets.all(8.0),
    elevation: 4.0,
    side: BorderSide.none,
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: lightBackground,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    elevation: 5.0,
    showDragHandle: true,
  ),
  navigationBarTheme: NavigationBarThemeData(
    indicatorColor: Color(0xff323f76),
    backgroundColor: primaryYellow,
    iconTheme: WidgetStateProperty.all(
      const IconThemeData(color: Color(0xFF232122)),
    ),
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: secondaryTomato,
    elevation: 0,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: primaryYellow,
    foregroundColor: lightText, // Black text/icon on yellow button
  ),
);

import 'package:flock_flutter/home.dart';
import 'package:flock_flutter/welcome.dart';
import 'package:flutter/material.dart';

class FlockApp extends StatelessWidget {
  final bool isLoggedIn;
  const FlockApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flock',
      // Removes the debug banner
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Define the black and white color scheme
        brightness: Brightness.light,
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Poppins',

        // Define custom text theme
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 48.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            letterSpacing: 1.5,
          ),
          headlineSmall: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          titleMedium: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          bodyMedium: TextStyle(fontSize: 14.0, color: Colors.black54),
          labelLarge: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        // Define custom input decoration theme for text fields
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 18.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.black),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.black, width: 2.0),
          ),
          labelStyle: const TextStyle(color: Colors.black54),
        ),

        // Define custom elevated button theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
        ),

        // Define custom text button theme
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
            ),
          ),
        ),

        // Define custom app bar theme
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      // Set the initial route to the new WelcomePage
      home: isLoggedIn ? const HomePage() : const WelcomePage(),
    );
  }
}

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
        primaryColor: Colors.green.shade800,
        scaffoldBackgroundColor: Color(0xFFF4FDDF),
        fontFamily: 'Poppins',
        useMaterial3: true,

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

        // Define the default AppBarTheme here
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(
            0xFFF4FDDF,
          ), // Set your desired default color
          foregroundColor: Colors.green.shade800,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.green.shade800),
          titleTextStyle: TextStyle(
            fontFamily: 'FlockFont', // Replace with your font family
            fontSize: 32.0, // Replace with a constant value
            color: Colors.green.shade800,
          ), // Set default color for icons and text
        ),

        // Define custom input decoration theme for text fields
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 18.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: Colors.green.shade800),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: Colors.green.shade800, width: 2.0),
          ),
          labelStyle: const TextStyle(color: Colors.black54),
        ),

        // Define custom elevated button theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            backgroundColor: Colors.green.shade800,
            foregroundColor: Color(0xFFF4FDDF),
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 15.0,
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              color: Color(0xFFF4FDDF),
            ),
          ),
        ),

        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.green.shade800,
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 15.0,
            ),
            side: BorderSide(
              color: Colors.green.shade800, // Your desired border color
              width: 2, // Your desired border width
            ),
            textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              color: Colors.green.shade800,
            ),
          ),
        ),

        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            foregroundColor:
                Colors.green.shade800, // Default icon color for all IconButtons
          ),
        ),

        // Define custom text button theme
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.green.shade800,
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ),
      // Set the initial route to the new WelcomePage
      home: isLoggedIn ? const HomePage() : const WelcomePage(),
    );
  }
}

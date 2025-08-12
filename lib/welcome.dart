import 'package:flock_flutter/login.dart';
import 'package:flock_flutter/signup.dart';
import 'package:flutter/material.dart';

// --- Welcome Page ---
// This is the initial screen with the animated brand name and login/signup options.
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    // Define fade animation
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    // Define slide animation
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 2),
              // Animated "Flock" text
              FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Text(
                    'Flock',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'FlockFont',
                      fontSize: 96,
                      color: Colors.black, // If you declared a bold variant
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Text(
                    'Fund it. Flock it. Flex it.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF283618),
                      fontSize: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.fontSize,
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 3),
              // Sign Up and Log In buttons
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: const StadiumBorder(), // This creates the pill shape
                  side: const BorderSide(
                    color: Colors.black, // Your desired border color
                    width: 2, // Your desired border width
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpPage()),
                  );
                },
                child: Text(
                  'Sign Up',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(), // This creates the pill shape
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: Text(
                  'Log In',
                  style: TextStyle(
                    fontSize: Theme.of(
                      context,
                    ).textTheme.headlineSmall?.fontSize, // Large text size
                    color: Colors.white, // Text color matching border
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

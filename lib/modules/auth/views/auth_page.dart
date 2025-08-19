import 'package:flutter/material.dart';
import 'login_view.dart';
import 'signup_view.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // A boolean to track whether to show the login or signup page.
  bool _showLoginPage = true;

  // A method to toggle between the two views.
  void toggleViews() {
    setState(() {
      _showLoginPage = !_showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showLoginPage) {
      // Pass the toggle method to the LoginView.
      return LoginView(onSignUpTapped: toggleViews);
    } else {
      // Pass the toggle method to the SignUpView.
      return SignUpView(onLoginTapped: toggleViews);
    }
  }
}

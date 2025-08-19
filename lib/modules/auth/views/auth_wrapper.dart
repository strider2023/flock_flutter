import 'package:flock_flutter/main_app_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';
import 'auth_page.dart'; // Your login page

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // Listen to the authentication state
    final authViewModel = context.watch<AuthViewModel>();

    switch (authViewModel.authState) {
      case AuthState.authenticated:
        // If authenticated, provide the token and show the main app
        return MainAppView(token: authViewModel.token!);
      case AuthState.unauthenticated:
        // If not, show the login page
        return const AuthPage();
      case AuthState.unknown:
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
  }
}

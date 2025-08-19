import 'package:flock_flutter/modules/auth/views/auth_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'common/themes/dark_theme.dart';
import 'common/themes/light_theme.dart';
import 'modules/auth/repositories/auth_repository.dart';
import 'modules/auth/viewmodels/auth_viewmodel.dart';

class FlockApp extends StatelessWidget {
  const FlockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthRepository>(create: (_) => AuthRepository()),
        ChangeNotifierProvider<AuthViewModel>(
          create: (context) =>
              AuthViewModel(repository: context.read<AuthRepository>()),
        ),
      ],
      child: MaterialApp(
        title: 'Flock',
        // Removes the debug banner
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        // Set the initial route to the new WelcomePage
        home: const AuthWrapper(),
      ),
    );
  }
}

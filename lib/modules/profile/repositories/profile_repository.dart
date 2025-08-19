// lib/profile/data/repositories/profile_repository.dart

import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class ProfileRepository {
  final String authToken;

  ProfileRepository({required this.authToken});

  // Simulates fetching user data from an API.
  Future<UserModel> getUserProfile() async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate latency
    // In a real app, this data would come from a network call.
    return UserModel(
      name: 'Jane Doe',
      phone: '+1 234 567 890',
      email: 'jane.doe@example.com',
      avatarUrl: '', // URL would go here
    );
  }

  // Handles the logout logic.
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
  }
}

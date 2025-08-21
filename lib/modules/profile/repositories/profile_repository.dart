// lib/profile/data/repositories/profile_repository.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/edit_profile_model.dart';
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

  Future<void> updateUserProfile(EditProfileModel profileData) async {
    await Future.delayed(const Duration(seconds: 1));
    debugPrint("Saving user: ${profileData.name}");
    if (profileData.name.isEmpty) {
      throw Exception("Name cannot be empty.");
    }
  }

  Future<UserModel> getEditableUserProfile() async {
    await Future.delayed(const Duration(milliseconds: 400));
    // In a real app, this would fetch the detailed user profile from your API.
    return UserModel(
      name: 'Jane Doe',
      email: 'jane.doe@example.com',
      phone: '+1 234 567 890',
      avatarUrl: '', // URL would be fetched from the backend
      dateOfBirth: DateTime(1995, 5, 23),
      gender: 'Female',
    );
  }

  // Handles the logout logic.
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
  }
}

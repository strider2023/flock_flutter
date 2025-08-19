// lib/profile/viewmodels/profile_viewmodel.dart

import 'package:flutter/material.dart';
import '../../auth/viewmodels/auth_viewmodel.dart';
import '../models/user_model.dart';
import '../repositories/profile_repository.dart'; // Assuming welcome.dart is in lib/

class ProfileViewModel extends ChangeNotifier {
  final ProfileRepository _repository;
  final AuthViewModel _authViewModel;

  ProfileViewModel({
    required ProfileRepository repository,
    required AuthViewModel authViewModel,
  }) : _repository = repository,
       _authViewModel = authViewModel {
    fetchUserProfile();
  }

  // --- STATE ---
  bool _isLoading = true;
  UserModel? _user;

  // --- GETTERS ---
  bool get isLoading => _isLoading;
  UserModel? get user => _user;

  // --- PUBLIC METHODS ---
  Future<void> fetchUserProfile() async {
    _isLoading = true;
    notifyListeners();

    try {
      _user = await _repository.getUserProfile();
    } catch (e) {
      debugPrint("Error fetching user profile: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    // Delegate the logout action to the AuthViewModel.
    await _authViewModel.logout();
    // No navigation code is needed here anymore!
  }
}

import 'package:flutter/material.dart';
import '../repositories/auth_repository.dart';
import 'auth_viewmodel.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  final AuthViewModel _authViewModel;

  LoginViewModel({
    required AuthRepository authRepository,
    required AuthViewModel authViewModel,
  }) : _authRepository = authRepository,
       _authViewModel = authViewModel;

  // --- STATE ---
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  // --- GETTERS ---
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // --- PUBLIC METHODS ---
  Future<void> login() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final token = await _authRepository.login(
        emailController.text,
        passwordController.text,
      );
      // On success, update the global AuthViewModel
      await _authViewModel.login(token);
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';

import '../models/mock_auth_models.dart';
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

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;

  Future<void> login() async {
    final validationMessage = _validateLoginForm();
    if (validationMessage != null) {
      _setError(validationMessage);
      return;
    }

    _setLoading(true);
    try {
      final response = await _authRepository.signInWithPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      _isLoading = false;
      await _authViewModel.setSession(response.session!);
    } on MockAuthException catch (e) {
      if (e.code == 'email_not_confirmed') {
        _authViewModel.requireEmailConfirmation(emailController.text.trim());
        return;
      }
      _setError(e.message);
    } catch (_) {
      _setError('Something went wrong. Please try again.');
    }
  }

  Future<void> resetPassword() async {
    final email = emailController.text.trim();
    if (!_isValidEmail(email)) {
      _setError('Enter a valid email to reset your password.');
      return;
    }

    _setLoading(true);
    try {
      await _authRepository.resetPasswordForEmail(email);
      _isLoading = false;
      _authViewModel.passwordResetRequested(email);
    } on MockAuthException catch (e) {
      _setError(e.message);
    } catch (_) {
      _setError('Something went wrong. Please try again.');
    }
  }

  void showSocialAuthUnavailable(String provider) {
    _successMessage = null;
    _errorMessage = '$provider sign-in is not configured yet.';
    notifyListeners();
  }

  String? _validateLoginForm() {
    final email = emailController.text.trim();
    if (!_isValidEmail(email)) {
      return 'Enter a valid email address.';
    }
    if (passwordController.text.isEmpty) {
      return 'Enter your password.';
    }
    return null;
  }

  bool _isValidEmail(String value) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value);
  }

  void _setLoading(bool value) {
    _isLoading = value;
    if (value) {
      _errorMessage = null;
      _successMessage = null;
    }
    notifyListeners();
  }

  void _setError(String message) {
    _isLoading = false;
    _successMessage = null;
    _errorMessage = message;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

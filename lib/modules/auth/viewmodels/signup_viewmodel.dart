import 'package:flutter/material.dart';

import '../models/mock_auth_models.dart';
import '../repositories/auth_repository.dart';
import 'auth_viewmodel.dart';

class SignUpViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  final AuthViewModel _authViewModel;

  SignUpViewModel({
    required AuthRepository authRepository,
    required AuthViewModel authViewModel,
  }) : _authRepository = authRepository,
       _authViewModel = authViewModel;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;

  Future<void> signUp() async {
    final validationMessage = _validateSignUpForm();
    if (validationMessage != null) {
      _setError(validationMessage);
      return;
    }

    _setLoading(true);
    try {
      final email = emailController.text.trim();
      await _authRepository.signUp(
        email: email,
        password: passwordController.text,
        data: {
          'full_name': nameController.text.trim(),
          'phone': phoneController.text.trim(),
          'account_type': 'consumer',
        },
      );
      _isLoading = false;
      _authViewModel.requireEmailConfirmation(email);
    } on MockAuthException catch (e) {
      _setError(e.message);
    } catch (_) {
      _setError('Something went wrong. Please try again.');
    }
  }

  Future<void> resendConfirmation() async {
    final email = emailController.text.trim();
    if (!_isValidEmail(email)) {
      _setError('Enter a valid email before resending confirmation.');
      return;
    }

    _setLoading(true);
    try {
      await _authRepository.resendConfirmation(email);
      _successMessage = 'Confirmation email sent again.';
      _errorMessage = null;
      notifyListeners();
    } on MockAuthException catch (e) {
      _setError(e.message);
    } catch (_) {
      _setError('Something went wrong. Please try again.');
    } finally {
      _setLoading(false);
    }
  }

  String? _validateSignUpForm() {
    if (nameController.text.trim().isEmpty) {
      return 'Enter your full name.';
    }
    if (!_isValidPhone(phoneController.text.trim())) {
      return 'Enter a valid 10 digit phone number.';
    }
    if (!_isValidEmail(emailController.text.trim())) {
      return 'Enter a valid email address.';
    }
    if (passwordController.text.length < 8) {
      return 'Password must be at least 8 characters.';
    }
    if (passwordController.text != confirmPasswordController.text) {
      return 'Passwords do not match.';
    }
    return null;
  }

  bool _isValidEmail(String value) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value);
  }

  bool _isValidPhone(String value) {
    return RegExp(r'^[6-9]\d{9}$').hasMatch(value);
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
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}

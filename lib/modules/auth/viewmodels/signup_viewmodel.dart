import 'package:flutter/material.dart';
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

  // --- STATE ---
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  // --- GETTERS ---
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // --- PUBLIC METHODS ---
  Future<void> signUp() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final token = await _authRepository.signUp(
        fullName: nameController.text,
        phone: phoneController.text,
        email: emailController.text,
        password: passwordController.text,
      );
      // On success, update the global AuthViewModel to log the user in
      await _authViewModel.login(token);
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

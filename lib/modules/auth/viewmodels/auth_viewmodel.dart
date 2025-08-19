import 'package:flutter/foundation.dart';

import '../repositories/auth_repository.dart';

// Represents the possible authentication states of the app.
enum AuthState { unknown, authenticated, unauthenticated }

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _repository;
  AuthState _authState = AuthState.unknown;
  String? _token;

  AuthViewModel({required AuthRepository repository})
    : _repository = repository {
    _checkAuthStatus();
  }

  // Getters
  AuthState get authState => _authState;
  String? get token => _token;

  // Checks for a token when the app starts.
  Future<void> _checkAuthStatus() async {
    _token = await _repository.getToken();
    if (_token != null) {
      _authState = AuthState.authenticated;
    } else {
      _authState = AuthState.unauthenticated;
    }
    notifyListeners();
  }

  // Called after a successful login.
  Future<void> login(String userToken) async {
    await _repository.saveToken(userToken);
    _token = userToken;
    _authState = AuthState.authenticated;
    notifyListeners();
  }

  // Called from the ProfileViewModel or settings page.
  Future<void> logout() async {
    await _repository.deleteToken();
    _token = null;
    _authState = AuthState.unauthenticated;
    notifyListeners();
  }
}

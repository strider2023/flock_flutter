import 'package:flutter/foundation.dart';

import '../models/mock_auth_models.dart';
import '../repositories/auth_repository.dart';

enum AuthState {
  unknown,
  authenticated,
  unauthenticated,
  emailConfirmationRequired,
  passwordResetRequested,
}

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _repository;
  AuthState _authState = AuthState.unknown;
  AuthSession? _session;
  String? _pendingEmail;

  AuthViewModel({required AuthRepository repository})
    : _repository = repository {
    _checkAuthStatus();
  }

  AuthState get authState => _authState;
  AuthSession? get session => _session;
  AuthUser? get user => _session?.user;
  String? get token => _session?.accessToken;
  String? get pendingEmail => _pendingEmail;

  Future<void> _checkAuthStatus() async {
    _session = await _repository.getCurrentSession();
    _authState = _session == null
        ? AuthState.unauthenticated
        : AuthState.authenticated;
    notifyListeners();
  }

  Future<void> setSession(AuthSession session) async {
    _session = session;
    _pendingEmail = null;
    _authState = AuthState.authenticated;
    notifyListeners();
  }

  void requireEmailConfirmation(String email) {
    _session = null;
    _pendingEmail = email;
    _authState = AuthState.emailConfirmationRequired;
    notifyListeners();
  }

  void passwordResetRequested(String email) {
    _session = null;
    _pendingEmail = email;
    _authState = AuthState.passwordResetRequested;
    notifyListeners();
  }

  void showUnauthenticated() {
    _session = null;
    _pendingEmail = null;
    _authState = AuthState.unauthenticated;
    notifyListeners();
  }

  Future<void> logout() async {
    await _repository.signOut();
    showUnauthenticated();
  }
}

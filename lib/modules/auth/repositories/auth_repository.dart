import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  static const _tokenKey = 'authToken';

  // Tries to get the token from storage.
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Saves the token after a successful login.
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // Deletes the token on logout.
  Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  // --- API Methods ---

  // Simulates a login API call.
  // In a real app, this would take email/password and return a token.
  Future<String> login(String email, String password) async {
    await Future.delayed(
      const Duration(seconds: 1),
    ); // Simulate network latency

    // Dummy validation
    if (email.isNotEmpty && password.isNotEmpty) {
      // Return a dummy token on success
      return 'dummy_auth_token_for_${email}';
    } else {
      // Throw an error on failure
      throw Exception('Invalid email or password');
    }
  }

  // Simulates a sign-up API call.
  Future<String> signUp({
    required String fullName,
    required String phone,
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    // Dummy validation
    if (email.isNotEmpty && password.isNotEmpty && fullName.isNotEmpty) {
      return 'dummy_auth_token_for_new_user_${email}';
    } else {
      throw Exception('Please fill all required fields');
    }
  }
}

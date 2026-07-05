import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/mock_auth_models.dart';

class AuthRepository {
  static const _sessionKey = 'mock_supabase_session';
  static const _usersKey = 'mock_supabase_users';

  Future<AuthSession?> getCurrentSession() async {
    final prefs = await SharedPreferences.getInstance();
    final sessionJson = prefs.getString(_sessionKey);
    if (sessionJson == null) return null;

    try {
      final session = AuthSession.fromJson(
        Map<String, dynamic>.from(jsonDecode(sessionJson) as Map),
      );
      if (session.isExpired) {
        await signOut();
        return null;
      }
      return session;
    } catch (_) {
      await signOut();
      return null;
    }
  }

  Future<AuthResponse> signInWithPassword({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 700));

    final normalizedEmail = _normalizeEmail(email);
    final record = await _findUserRecord(normalizedEmail);
    if (record == null || record.password != password) {
      throw const MockAuthException(
        message: 'Invalid email or password.',
        code: 'invalid_credentials',
        statusCode: 400,
      );
    }

    if (!record.user.isEmailConfirmed) {
      throw const MockAuthException(
        message: 'Please confirm your email before logging in.',
        code: 'email_not_confirmed',
        statusCode: 400,
      );
    }

    final session = _createSession(record.user);
    await _saveSession(session);
    return AuthResponse(user: record.user, session: session);
  }

  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required Map<String, dynamic> data,
  }) async {
    await Future.delayed(const Duration(milliseconds: 700));

    final normalizedEmail = _normalizeEmail(email);
    final records = await _loadUserRecords();
    if (records.any((record) => record.user.email == normalizedEmail)) {
      throw const MockAuthException(
        message: 'A user with this email already exists.',
        code: 'user_already_registered',
        statusCode: 400,
      );
    }

    final user = AuthUser(
      id: 'mock-user-${DateTime.now().microsecondsSinceEpoch}',
      email: normalizedEmail,
      phone: data['phone'] as String?,
      userMetadata: Map<String, dynamic>.from(data),
    );
    records.add(_MockAuthRecord(user: user, password: password));
    await _saveUserRecords(records);
    return AuthResponse(user: user);
  }

  Future<AuthUser> confirmEmail(String email) async {
    await Future.delayed(const Duration(milliseconds: 400));

    final normalizedEmail = _normalizeEmail(email);
    final records = await _loadUserRecords();
    final index = records.indexWhere(
      (record) => record.user.email == normalizedEmail,
    );
    if (index == -1) {
      throw const MockAuthException(
        message: 'No account was found for this email.',
        code: 'user_not_found',
        statusCode: 404,
      );
    }

    final confirmedUser = records[index].user.copyWith(
      emailConfirmedAt: DateTime.now(),
    );
    records[index] = records[index].copyWith(user: confirmedUser);
    await _saveUserRecords(records);
    return confirmedUser;
  }

  Future<void> resendConfirmation(String email) async {
    await Future.delayed(const Duration(milliseconds: 400));

    final record = await _findUserRecord(_normalizeEmail(email));
    if (record == null) {
      throw const MockAuthException(
        message: 'No account was found for this email.',
        code: 'user_not_found',
        statusCode: 404,
      );
    }
    if (record.user.isEmailConfirmed) {
      throw const MockAuthException(
        message: 'This email is already confirmed.',
        code: 'email_already_confirmed',
        statusCode: 400,
      );
    }
  }

  Future<void> resetPasswordForEmail(String email) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final record = await _findUserRecord(_normalizeEmail(email));
    if (record == null) {
      throw const MockAuthException(
        message: 'No account was found for this email.',
        code: 'user_not_found',
        statusCode: 404,
      );
    }
  }

  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_sessionKey);
  }

  Future<void> _saveSession(AuthSession session) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_sessionKey, jsonEncode(session.toJson()));
  }

  AuthSession _createSession(AuthUser user) {
    final timestamp = DateTime.now().microsecondsSinceEpoch;
    return AuthSession(
      accessToken: 'mock-access-token-$timestamp',
      refreshToken: 'mock-refresh-token-$timestamp',
      expiresAt: DateTime.now().add(const Duration(hours: 1)),
      user: user,
    );
  }

  Future<_MockAuthRecord?> _findUserRecord(String normalizedEmail) async {
    final records = await _loadUserRecords();
    for (final record in records) {
      if (record.user.email == normalizedEmail) {
        return record;
      }
    }
    return null;
  }

  Future<List<_MockAuthRecord>> _loadUserRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString(_usersKey);
    if (usersJson == null) return [];

    try {
      final decoded = jsonDecode(usersJson) as List;
      return decoded
          .map(
            (item) => _MockAuthRecord.fromJson(
              Map<String, dynamic>.from(item as Map),
            ),
          )
          .toList();
    } catch (_) {
      await prefs.remove(_usersKey);
      return [];
    }
  }

  Future<void> _saveUserRecords(List<_MockAuthRecord> records) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _usersKey,
      jsonEncode(records.map((record) => record.toJson()).toList()),
    );
  }

  String _normalizeEmail(String email) => email.trim().toLowerCase();
}

class _MockAuthRecord {
  final AuthUser user;
  final String password;

  const _MockAuthRecord({required this.user, required this.password});

  _MockAuthRecord copyWith({AuthUser? user, String? password}) {
    return _MockAuthRecord(
      user: user ?? this.user,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toJson() {
    return {'user': user.toJson(), 'password': password};
  }

  factory _MockAuthRecord.fromJson(Map<String, dynamic> json) {
    return _MockAuthRecord(
      user: AuthUser.fromJson(Map<String, dynamic>.from(json['user'] as Map)),
      password: json['password'] as String,
    );
  }
}

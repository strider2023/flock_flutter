class MockAuthException implements Exception {
  final String message;
  final String code;
  final int? statusCode;

  const MockAuthException({
    required this.message,
    required this.code,
    this.statusCode,
  });

  @override
  String toString() => message;
}

class AuthUser {
  final String id;
  final String email;
  final String? phone;
  final DateTime? emailConfirmedAt;
  final Map<String, dynamic> userMetadata;

  const AuthUser({
    required this.id,
    required this.email,
    this.phone,
    this.emailConfirmedAt,
    this.userMetadata = const {},
  });

  bool get isEmailConfirmed => emailConfirmedAt != null;

  AuthUser copyWith({
    String? id,
    String? email,
    String? phone,
    DateTime? emailConfirmedAt,
    Map<String, dynamic>? userMetadata,
  }) {
    return AuthUser(
      id: id ?? this.id,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      emailConfirmedAt: emailConfirmedAt ?? this.emailConfirmedAt,
      userMetadata: userMetadata ?? this.userMetadata,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'email_confirmed_at': emailConfirmedAt?.toIso8601String(),
      'user_metadata': userMetadata,
    };
  }

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      id: json['id'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      emailConfirmedAt: json['email_confirmed_at'] == null
          ? null
          : DateTime.parse(json['email_confirmed_at'] as String),
      userMetadata: Map<String, dynamic>.from(
        json['user_metadata'] as Map? ?? {},
      ),
    );
  }
}

class AuthSession {
  final String accessToken;
  final String refreshToken;
  final DateTime expiresAt;
  final AuthUser user;

  const AuthSession({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
    required this.user,
  });

  bool get isExpired => DateTime.now().isAfter(expiresAt);

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'expires_at': expiresAt.toIso8601String(),
      'user': user.toJson(),
    };
  }

  factory AuthSession.fromJson(Map<String, dynamic> json) {
    return AuthSession(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      expiresAt: DateTime.parse(json['expires_at'] as String),
      user: AuthUser.fromJson(Map<String, dynamic>.from(json['user'] as Map)),
    );
  }
}

class AuthResponse {
  final AuthUser user;
  final AuthSession? session;

  const AuthResponse({required this.user, this.session});
}

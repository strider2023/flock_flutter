import 'package:flutter_test/flutter_test.dart';
import 'package:flock_flutter/modules/auth/models/mock_auth_models.dart';
import 'package:flock_flutter/modules/auth/repositories/auth_repository.dart';
import 'package:flock_flutter/modules/auth/viewmodels/auth_viewmodel.dart';
import 'package:flock_flutter/modules/auth/viewmodels/login_viewmodel.dart';
import 'package:flock_flutter/modules/auth/viewmodels/signup_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('AuthRepository', () {
    test('signup creates an unconfirmed user without a session', () async {
      final repository = AuthRepository();

      final response = await repository.signUp(
        email: 'Test@Example.com',
        password: 'password123',
        data: {'full_name': 'Test User', 'phone': '9876543210'},
      );

      expect(response.session, isNull);
      expect(response.user.email, 'test@example.com');
      expect(response.user.emailConfirmedAt, isNull);
      expect(response.user.userMetadata['full_name'], 'Test User');
    });

    test('duplicate signup returns user_already_registered', () async {
      final repository = AuthRepository();
      await repository.signUp(
        email: 'test@example.com',
        password: 'password123',
        data: {'full_name': 'Test User', 'phone': '9876543210'},
      );

      expect(
        () => repository.signUp(
          email: 'test@example.com',
          password: 'password123',
          data: {'full_name': 'Test User', 'phone': '9876543210'},
        ),
        throwsA(
          isA<MockAuthException>().having(
            (e) => e.code,
            'code',
            'user_already_registered',
          ),
        ),
      );
    });

    test('login before confirmation returns email_not_confirmed', () async {
      final repository = AuthRepository();
      await repository.signUp(
        email: 'test@example.com',
        password: 'password123',
        data: {'full_name': 'Test User', 'phone': '9876543210'},
      );

      expect(
        () => repository.signInWithPassword(
          email: 'test@example.com',
          password: 'password123',
        ),
        throwsA(
          isA<MockAuthException>().having(
            (e) => e.code,
            'code',
            'email_not_confirmed',
          ),
        ),
      );
    });

    test('mock email confirmation allows login and session restore', () async {
      final repository = AuthRepository();
      await repository.signUp(
        email: 'test@example.com',
        password: 'password123',
        data: {'full_name': 'Test User', 'phone': '9876543210'},
      );
      await repository.confirmEmail('test@example.com');

      final response = await repository.signInWithPassword(
        email: 'test@example.com',
        password: 'password123',
      );
      final restoredSession = await repository.getCurrentSession();

      expect(response.session, isNotNull);
      expect(restoredSession?.accessToken, response.session?.accessToken);
      expect(restoredSession?.user.email, 'test@example.com');
    });

    test('wrong password returns invalid_credentials', () async {
      final repository = AuthRepository();
      await repository.signUp(
        email: 'test@example.com',
        password: 'password123',
        data: {'full_name': 'Test User', 'phone': '9876543210'},
      );
      await repository.confirmEmail('test@example.com');

      expect(
        () => repository.signInWithPassword(
          email: 'test@example.com',
          password: 'wrong-password',
        ),
        throwsA(
          isA<MockAuthException>().having(
            (e) => e.code,
            'code',
            'invalid_credentials',
          ),
        ),
      );
    });

    test('forgot password succeeds for a known email', () async {
      final repository = AuthRepository();
      await repository.signUp(
        email: 'test@example.com',
        password: 'password123',
        data: {'full_name': 'Test User', 'phone': '9876543210'},
      );

      await expectLater(
        repository.resetPasswordForEmail('test@example.com'),
        completes,
      );
    });

    test('logout clears the stored session', () async {
      final repository = AuthRepository();
      await repository.signUp(
        email: 'test@example.com',
        password: 'password123',
        data: {'full_name': 'Test User', 'phone': '9876543210'},
      );
      await repository.confirmEmail('test@example.com');
      await repository.signInWithPassword(
        email: 'test@example.com',
        password: 'password123',
      );

      await repository.signOut();

      expect(await repository.getCurrentSession(), isNull);
    });
  });

  group('Auth viewmodel validation', () {
    test('empty login form blocks repository calls', () async {
      final repository = AuthRepository();
      final authViewModel = AuthViewModel(repository: repository);
      final viewModel = LoginViewModel(
        authRepository: repository,
        authViewModel: authViewModel,
      );

      await viewModel.login();

      expect(viewModel.errorMessage, 'Enter a valid email address.');
      expect(authViewModel.authState, isNot(AuthState.authenticated));
    });

    test('invalid signup form blocks repository calls', () async {
      final repository = AuthRepository();
      final authViewModel = AuthViewModel(repository: repository);
      final viewModel = SignUpViewModel(
        authRepository: repository,
        authViewModel: authViewModel,
      );

      await viewModel.signUp();

      expect(viewModel.errorMessage, 'Enter your full name.');
      expect(authViewModel.authState, isNot(AuthState.authenticated));
    });
  });
}

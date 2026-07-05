import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/mock_auth_models.dart';
import '../repositories/auth_repository.dart';
import '../viewmodels/auth_viewmodel.dart';
import 'login_view.dart';
import 'signup_view.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _showLoginPage = true;

  void toggleViews() {
    context.read<AuthViewModel>().showUnauthenticated();
    setState(() {
      _showLoginPage = !_showLoginPage;
    });
  }

  void _showLogin() {
    context.read<AuthViewModel>().showUnauthenticated();
    setState(() {
      _showLoginPage = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();

    if (authViewModel.authState == AuthState.emailConfirmationRequired) {
      return EmailConfirmationView(
        email: authViewModel.pendingEmail ?? '',
        onBackToLogin: _showLogin,
      );
    }

    if (authViewModel.authState == AuthState.passwordResetRequested) {
      return PasswordResetRequestedView(
        email: authViewModel.pendingEmail ?? '',
        onBackToLogin: _showLogin,
      );
    }

    if (_showLoginPage) {
      return LoginView(onSignUpTapped: toggleViews);
    }
    return SignUpView(onLoginTapped: toggleViews);
  }
}

class EmailConfirmationView extends StatefulWidget {
  final String email;
  final VoidCallback onBackToLogin;

  const EmailConfirmationView({
    super.key,
    required this.email,
    required this.onBackToLogin,
  });

  @override
  State<EmailConfirmationView> createState() => _EmailConfirmationViewState();
}

class _EmailConfirmationViewState extends State<EmailConfirmationView> {
  bool _isLoading = false;
  String? _message;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Confirm your email',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'We sent a confirmation link to ${widget.email}. This mock flow lets you simulate that link for Phase 1.',
                    textAlign: TextAlign.center,
                  ),
                  if (_message != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      _message!,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ],
                  if (_errorMessage != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      _errorMessage!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                  const SizedBox(height: 28),
                  if (_isLoading)
                    const Center(child: CircularProgressIndicator())
                  else ...[
                    ElevatedButton(
                      onPressed: _confirmEmail,
                      child: const Text('Simulate Email Confirmation'),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: _resendConfirmation,
                      child: const Text('Resend Confirmation'),
                    ),
                    TextButton(
                      onPressed: widget.onBackToLogin,
                      child: const Text('Back to Log In'),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _confirmEmail() async {
    setState(() {
      _isLoading = true;
      _message = null;
      _errorMessage = null;
    });

    try {
      await context.read<AuthRepository>().confirmEmail(widget.email);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email confirmed. You can log in now.')),
      );
      widget.onBackToLogin();
    } on MockAuthException catch (e) {
      setState(() => _errorMessage = e.message);
    } catch (_) {
      setState(() => _errorMessage = 'Something went wrong. Please try again.');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _resendConfirmation() async {
    setState(() {
      _isLoading = true;
      _message = null;
      _errorMessage = null;
    });

    try {
      await context.read<AuthRepository>().resendConfirmation(widget.email);
      setState(() => _message = 'Confirmation email sent again.');
    } on MockAuthException catch (e) {
      setState(() => _errorMessage = e.message);
    } catch (_) {
      setState(() => _errorMessage = 'Something went wrong. Please try again.');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}

class PasswordResetRequestedView extends StatelessWidget {
  final String email;
  final VoidCallback onBackToLogin;

  const PasswordResetRequestedView({
    super.key,
    required this.email,
    required this.onBackToLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Check your email',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Password reset instructions were sent to $email.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 28),
                  ElevatedButton(
                    onPressed: onBackToLogin,
                    child: const Text('Back to Log In'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

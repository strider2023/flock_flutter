import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/widgets/social_login_button.dart';
import '../repositories/auth_repository.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../viewmodels/login_viewmodel.dart';

class LoginView extends StatefulWidget {
  final VoidCallback onSignUpTapped;
  const LoginView({super.key, required this.onSignUpTapped});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
    with SingleTickerProviderStateMixin {
  bool _isPasswordVisible = false;

  // --- ANIMATION CONTROLLERS ---
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _logoSlideAnimation;
  late Animation<Offset> _formSlideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
    );
    _logoSlideAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(0, 0.1)).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
          ),
        );

    _formSlideAnimation =
        Tween<Offset>(begin: const Offset(0, 1.5), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
          ),
        );

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(
        authRepository: context.read<AuthRepository>(),
        authViewModel: context.read<AuthViewModel>(),
      ),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Consumer<LoginViewModel>(
                  builder: (context, viewModel, child) {
                    return _buildAnimatedForm(context, viewModel);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedForm(BuildContext context, LoginViewModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // --- Animated Header ---
        SlideTransition(
          position: _logoSlideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              children: [
                Text(
                  'Flock',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'FlockFont', fontSize: 72),
                ),
                Text(
                  'Fund it. Flock it. Flex it.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Theme.of(
                      context,
                    ).textTheme.headlineSmall?.fontSize,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 60),

        // --- Animated Login Form ---
        SlideTransition(
          position: _formSlideAnimation,
          child: _buildLoginForm(context, viewModel),
        ),
      ],
    );
  }

  Widget _buildLoginForm(BuildContext context, LoginViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // --- Email Input Field ---
        TextField(
          controller: viewModel.emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(labelText: 'Email'),
        ),
        const SizedBox(height: 16),

        // --- Password Input Field ---
        TextField(
          controller: viewModel.passwordController,
          obscureText: !_isPasswordVisible,
          decoration: InputDecoration(
            labelText: 'Password',
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: const Text('Forgot Password?'),
          ),
        ),
        const SizedBox(height: 24),

        // --- Login Button ---
        if (viewModel.isLoading)
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: CircularProgressIndicator(),
            ),
          )
        else
          ElevatedButton(
            onPressed: viewModel.login,
            child: const Text('Log In'),
          ),

        if (viewModel.errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              viewModel.errorMessage!,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ),
        const SizedBox(height: 24),

        // ✨ ADDED: Social Login Divider & Buttons
        const Row(
          children: <Widget>[
            Expanded(child: Divider(color: Colors.black26)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Or continue with',
                style: TextStyle(color: Colors.black54),
              ),
            ),
            Expanded(child: Divider(color: Colors.black26)),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialLoginButton(type: 'Google', onPressed: () {}),
            const SizedBox(width: 16),
            SocialLoginButton(type: 'Apple', onPressed: () {}),
          ],
        ),
        const SizedBox(height: 24),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Don't have an account?"),
            TextButton(
              onPressed: widget.onSignUpTapped,
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ],
    );
  }
}

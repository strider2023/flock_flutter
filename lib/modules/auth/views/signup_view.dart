import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../repositories/auth_repository.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../viewmodels/signup_viewmodel.dart';

// Converted to a StatefulWidget to manage the password visibility state locally.
class SignUpView extends StatefulWidget {
  final VoidCallback onLoginTapped;
  const SignUpView({super.key, required this.onLoginTapped});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  // This state is purely for the UI and doesn't belong in the ViewModel.
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    // The ChangeNotifierProvider creates the ViewModel for this view.
    return ChangeNotifierProvider(
      create: (context) => SignUpViewModel(
        authRepository: context.read<AuthRepository>(),
        authViewModel: context.read<AuthViewModel>(),
      ),
      child: Scaffold(
        body: Consumer<SignUpViewModel>(
          builder: (context, viewModel, child) {
            return SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 400),
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: _buildSignUpForm(context, viewModel),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Helper method to build the form UI.
  Widget _buildSignUpForm(BuildContext context, SignUpViewModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          'Join the Flock.',
          textAlign: TextAlign.center,
          style: GoogleFonts.tinos(
            fontSize: Theme.of(context).textTheme.headlineMedium?.fontSize,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Fill in the details to get flocking.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 40),

        // --- Full Name Input Field ---
        TextField(
          controller: viewModel.nameController,
          keyboardType: TextInputType.name,
          decoration: const InputDecoration(labelText: 'Full Name'),
        ),
        const SizedBox(height: 16),

        // --- Phone Number Input Field ---
        TextField(
          controller: viewModel.phoneController,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(labelText: 'Phone'),
        ),
        const SizedBox(height: 16),

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
                // Use setState to toggle visibility, rebuilding only this widget.
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 24),

        // --- Sign Up Button ---
        if (viewModel.isLoading)
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: CircularProgressIndicator(),
            ),
          )
        else
          ElevatedButton(
            // onPressed is linked to the ViewModel's signUp method.
            onPressed: viewModel.signUp,
            child: const Text('Join Flock'),
          ),

        // --- Error Message Display ---
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Already have an account?"),
            TextButton(
              onPressed: widget.onLoginTapped,
              child: const Text('Log In'),
            ),
          ],
        ),
      ],
    );
  }
}

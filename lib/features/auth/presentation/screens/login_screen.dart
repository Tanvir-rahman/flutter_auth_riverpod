import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:resto_lite/features/auth/auth.dart';
import 'package:resto_lite/features/auth/presentation/notifiers/login_form_notifier.dart';
import 'package:resto_lite/features/auth/presentation/state/login_form_state.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final notifier = ref.read(loginFormNotifierProvider.notifier);
    final postLogin = ref.read(postLoginProvider);

    try {
      await notifier.login(postLogin);
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(loginFormNotifierProvider);
    final notifier = ref.read(loginFormNotifierProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                _buildEmailField(formState, notifier),
                const SizedBox(height: 16),
                _buildPasswordField(formState, notifier),
                const SizedBox(height: 24),
                _buildLoginButton(formState, notifier),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField(
      LoginFormState formState, LoginFormNotifier notifier) {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Email',
        prefixIcon: const Icon(Icons.email),
        errorText: formState.emailError?.message,
      ),
      keyboardType: TextInputType.emailAddress,
      onChanged: notifier.updateEmail,
      validator: (_) => formState.emailError?.message,
    );
  }

  Widget _buildPasswordField(
      LoginFormState formState, LoginFormNotifier notifier) {
    return TextFormField(
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: 'Password',
        prefixIcon: const Icon(Icons.lock),
        errorText: formState.passwordError?.message,
        suffixIcon: IconButton(
          icon: Icon(
            formState.isObscurePassword
                ? Icons.visibility
                : Icons.visibility_off,
          ),
          onPressed: notifier.togglePasswordVisibility,
        ),
      ),
      obscureText: formState.isObscurePassword,
      onChanged: notifier.updatePassword,
      validator: (_) => formState.passwordError?.message,
    );
  }

  Widget _buildLoginButton(
      LoginFormState formState, LoginFormNotifier notifier) {
    return ElevatedButton(
      onPressed: formState.isLoading || !notifier.isValid ? null : _handleLogin,
      child: formState.isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Text('Login'),
    );
  }
}

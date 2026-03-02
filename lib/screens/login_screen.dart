import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login/core/widgets/email_field.dart';
import 'package:login/core/widgets/password_field.dart';
import 'package:login/core/widgets/sign_in_button.dart';
import 'package:login/core/widgets/google_sign_in_button.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static String routeName = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignIn() {
    context.goNamed(HomeScreen.routeName);
  }

  void _handleGoogleSignIn() {
    debugPrint("Google Sign In presionado");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [ 
              SignInButton(
                formKey: _formKey,
                onSuccess: _handleSignIn,
              ),
              const SizedBox(height: 20),
              GoogleSignInButton(
                onPressed: _handleGoogleSignIn,
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              const Text(
                "Multiverse",
                style: TextStyle(
                  fontSize: 45,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),

              const Icon(Icons.menu_book, size: 120, color: Colors.white),

              const SizedBox(height: 30),
              EmailField(controller: _emailController),
              const SizedBox(height: 10),
              PasswordField(controller: _passwordController),
            ],
          ),
        ),
      ),
    );
  }
}

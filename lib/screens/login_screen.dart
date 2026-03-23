import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login/screens/home_screen.dart';
import 'package:login/screens/register_screen.dart';
import 'package:login/services/auth_service.dart';
import 'package:login/core/widgets/email_field.dart';
import 'package:login/core/widgets/password_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  String errorMessage = '';
  bool isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Login con email
  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final user = await _authService.signInWithEmail(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (!mounted) return;

      if (user != null) {
        context.goNamed(HomeScreen.routeName);
      } else {
        setState(() {
          errorMessage = "Correo o contraseña incorrectos";
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Error al iniciar sesión: ${e.toString()}";
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  // Login con Google
  Future<void> _handleGoogleLogin() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final user = await _authService.signInWithGoogle();

      if (!mounted) return;

      if (user != null) {
        context.goNamed(HomeScreen.routeName);
      } else {
        setState(() {
          errorMessage = "Inicio de sesión con Google cancelado o fallido";
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Error de Google: ${e.toString()}";
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Iniciar sesión")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 20),

              // Email
              EmailField(controller: _emailController),
              const SizedBox(height: 10),

              // Contraseña
              PasswordField(controller: _passwordController),
              const SizedBox(height: 20),

              // Botón Login
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _handleLogin,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Iniciar sesión",
                          style: TextStyle(fontSize: 18),
                        ),
                ),
              ),
              const SizedBox(height: 15),

              // Botón Google Login
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: isLoading ? null : _handleGoogleLogin,
                  icon: const Icon(Icons.login),
                  label: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Iniciar sesión con Google"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Ir a Register
              TextButton(
                onPressed: () {
                  context.goNamed(RegisterScreen.routeName);
                },
                child: const Text(
                  "¿No tienes cuenta? Crear cuenta",
                  style: TextStyle(color: Colors.white),
                ),
              ),

              // Mensaje de error
              if (errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
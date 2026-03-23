import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login/services/auth_service.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'package:login/core/widgets/email_field.dart';
import 'package:login/core/widgets/password_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const String routeName = "register";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  String errorMessage = '';
  bool isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Registro con email
  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        errorMessage = "Las contraseñas no coinciden";
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final user = await _authService.register(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (!mounted) return;

      if (user != null) {
        context.goNamed(HomeScreen.routeName);
      } else {
        setState(() {
          errorMessage = "No se pudo crear la cuenta";
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Error al crear la cuenta: ${e.toString()}";
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  // Registro / Login con Google
  Future<void> _handleGoogleRegister() async {
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
          errorMessage = "Registro con Google cancelado o fallido";
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
      appBar: AppBar(title: const Text("Crear cuenta")),
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
              const SizedBox(height: 10),

              // Confirmar contraseña
              PasswordField(controller: _confirmPasswordController),
              const SizedBox(height: 20),

              // Botón Registrar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _handleRegister,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Registrarse",
                          style: TextStyle(fontSize: 18),
                        ),
                ),
              ),
              const SizedBox(height: 15),

              // Botón Google Register
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: isLoading ? null : _handleGoogleRegister,
                  icon: const Icon(Icons.login),
                  label: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Registrarse con Google"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),


              // Ir a Login
              TextButton(
                onPressed: () {
                  context.goNamed(LoginScreen.routeName);
                },
                child: const Text(
                  "¿Ya tienes cuenta? Iniciar sesión",
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
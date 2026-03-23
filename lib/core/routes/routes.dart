import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/screens/escribir_historia.dart';
import 'package:login/screens/home_screen.dart';
import 'package:login/screens/novela_detail_screen.dart';
import 'package:login/screens/register_screen.dart';
import 'package:login/screens/search_screen.dart';
import 'package:login/screens/library_screen.dart';
import 'package:login/screens/login_screen.dart';
import 'package:login/screens/profile_screen.dart';
import 'package:login/screens/write_screen.dart';
import 'package:login/screens/crear_historia.dart';
import 'package:login/screens/proyectos_screen.dart';
import 'package:login/screens/splash_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: "/splash",

  redirect: (context, state) {
    final user = FirebaseAuth.instance.currentUser;

    final goingToLogin = state.uri.path == "/login";
    final goingToSplash = state.uri.path == "/splash";
    final goingToRegister = state.uri.path == "/register";
    if (goingToSplash || goingToRegister) return null;

    if (user == null && !goingToLogin) {
      return "/login";
    }

    if (user != null && goingToLogin) {
      return "/";
    }

    return null;
  },

  routes: [
    GoRoute(
      path: "/splash",
      name: "splash",
      builder: (context, state) => const SplashScreen(),
    ),

    GoRoute(
      path: "/login",
      name: LoginScreen.routeName,
      builder: (context, state) => const LoginScreen(),
    ),

    GoRoute(
      path: "/",
      name: HomeScreen.routeName,
      builder: (context, state) => const HomeScreen(),
    ),

    GoRoute(
      path: "/search",
      name: SearchScreen.routeName,
      builder: (context, state) => const SearchScreen(),
    ),

    GoRoute(
      path: "/library",
      name: LibraryScreen.routeName,
      builder: (context, state) => const LibraryScreen(),
    ),

    GoRoute(
      path: "/write",
      name: WriteScreen.routeName,
      builder: (context, state) => const WriteScreen(),
    ),

    GoRoute(
      path: "/crear_historia",
      name: CrearHistoriaScreen.routeName,
      builder: (context, state) => const CrearHistoriaScreen(),
    ),

    // RUTA CORRECTA PARA ESCRIBIR HISTORIA
    GoRoute(
      path: "/escribir_historia",
      name: EscribirHistoriaScreen.routeName,
      builder: (context, state) {
        final extra = state.extra;

        if (extra != null && extra is Map<String, dynamic>) {
          final proyectoIndex = extra['proyectoIndex'] as int;
          final capituloIndex = extra['capituloIndex'] as int?;
          return EscribirHistoriaScreen(
            proyectoIndex: proyectoIndex,
            capituloIndex: capituloIndex,
          );
        }

        return const Scaffold(
          backgroundColor: Color(0xFF0B1F4B),
          body: Center(
            child: Text(
              "No se encontró la historia",
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    ),

    GoRoute(
      path: "/proyectos",
      name: ProyectosScreen.routeName,
      builder: (context, state) => const ProyectosScreen(),
    ),

    GoRoute(
      path: "/profile",
      name: ProfileScreen.routeName,
      builder: (context, state) => const ProfileScreen(),
    ),

    GoRoute(
      path: "/detail",
      name: NovelDetailScreen.routeName,
      builder: (context, state) {
        final data = state.extra;

        if (data != null && data is Map<String, dynamic>) {
          return NovelDetailScreen(historia: data);
        }

        return const Scaffold(
          body: Center(
            child: Text(
              "No se encontró la historia",
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    ),

    GoRoute(
      path: "/register",
      name: RegisterScreen.routeName,
      builder: (context, state) => const RegisterScreen(),
    ),
  ],
);
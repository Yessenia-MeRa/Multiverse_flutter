import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login/core/data/library_data.dart';
import 'package:login/core/data/novelas_data.dart';
import 'package:login/core/widgets/custom_bottom_nav.dart';
import 'package:login/screens/home_screen.dart';
import 'package:login/screens/library_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const String routeName = "profile";

  @override
  Widget build(BuildContext context) {
    final String username = "Usuario123";
    final int historiasPublicadas = 0; 
    final int siguiendo = 5;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil"),
        backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.goNamed(HomeScreen.routeName),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: "Cerrar sesión",
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Sesión cerrada"),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 55,
              backgroundColor: const Color(0xFF283593),
              child: Text(
                username[0].toUpperCase(),
                style: const TextStyle(
                    fontSize: 42, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              username,
              style: const TextStyle(
                  color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _statCard("Historias", historiasPublicadas.toString(), Icons.menu_book,
                    onTap: () {
                  if (historiasPublicadas > 0) {



                    // abrir historias si las tuviera
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Aún no tienes historias"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                }),


                // FAVORITOS
                ValueListenableBuilder<List<Novela>>(
                  valueListenable: LibraryData.favoritos,
                  builder: (context, favoritos, _) {
                    return _statCard("Favoritos", favoritos.length.toString(),
                        Icons.favorite, onTap: () {
                      if (favoritos.isNotEmpty) {
                        context.pushNamed(LibraryScreen.routeName);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("No tienes favoritos aún"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    });
                  },
                ),
                _statCard("Siguiendo", siguiendo.toString(), Icons.person_add,
                    onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Lista de siguiendo no disponible"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 4),
    );
  }

  Widget _statCard(String title, String value, IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 110,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF1A237E),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(),blurRadius: 6, offset: const Offset(2, 3)),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 28),
            const SizedBox(height: 10),
            Text(value,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(title,
                style: const TextStyle(color: Colors.white70, fontSize: 13),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
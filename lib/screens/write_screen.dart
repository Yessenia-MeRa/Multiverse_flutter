import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login/screens/crear_historia.dart';
import 'package:login/screens/proyectos_screen.dart';

class WriteScreen extends StatelessWidget {
  static const String routeName = "write";
  const WriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); 

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis Historias"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              context.pop();
            } else {
              context.goNamed('home'); 
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // Crear Historia
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.white),
              title: const Text(
                "Crear Historia",
                style: TextStyle(color: Colors.white),
              ),
              tileColor: theme.primaryColor, 
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              onTap: () => context.pushNamed(CrearHistoriaScreen.routeName),
            ),

            const SizedBox(height: 16),

            // Proyectos
            ListTile(
              leading: const Icon(Icons.folder, color: Colors.white),
              title: const Text(
                "Proyectos",
                style: TextStyle(color: Colors.white),
              ),
              tileColor: theme.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              onTap: () => context.pushNamed(ProyectosScreen.routeName),
            ),
          ],
        ),
      ),
    );
  }
}
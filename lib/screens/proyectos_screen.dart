import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:login/providers/project_provider.dart';
import 'package:login/screens/escribir_historia.dart';
import 'package:login/screens/write_screen.dart';

class ProyectosScreen extends StatelessWidget {
  static const String routeName = "proyectos";
  const ProyectosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProjectProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Proyectos"),
        centerTitle: true,
        backgroundColor: const Color(0xFF2C2C3E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.goNamed(WriteScreen.routeName);
          },
        ),
      ),
      body: provider.proyectos.isEmpty
          ? const Center(
              child: Text(
                "No hay proyectos aún",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            )
          : ListView.separated(
              itemCount: provider.proyectos.length,
              separatorBuilder: (_, _) => const Divider(color: Colors.white24),
              itemBuilder: (context, index) {
                final proyecto = provider.proyectos[index];
                return ListTile(
                  title: Text(
                    proyecto['titulo'] ?? "Sin título",
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    proyecto['introduccion'] ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white70),
                  ),
                  leading: const Icon(Icons.folder, color: Colors.white),
                  onTap: () => context.pushNamed(
                    EscribirHistoriaScreen.routeName,
                    extra: {
                      'proyectoIndex': index,
                      'proyecto': proyecto, // 🔥 Aquí enviamos el proyecto completo
                    },
                  ),
                );
              },
            ),
    );
  }
}
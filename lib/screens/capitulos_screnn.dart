import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:login/providers/project_provider.dart';

class CapituloScreen extends StatelessWidget {
  final int proyectoIndex;
  final int capituloIndex;

  const CapituloScreen({
    super.key,
    required this.proyectoIndex,
    required this.capituloIndex,
  });

  @override
  Widget build(BuildContext context) {
    final proyecto = Provider.of<ProjectProvider>(context).proyectos[proyectoIndex];
    final capitulos = proyecto['capitulos'] as List<dynamic>;
    final capitulo = capitulos[capituloIndex];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(proyecto['titulo'] ?? "Historia"),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Capítulo ${capituloIndex + 1}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  capitulo['contenido'] ?? "",
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
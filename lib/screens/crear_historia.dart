import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:login/providers/project_provider.dart';
import 'package:login/screens/escribir_historia.dart';

class CrearHistoriaScreen extends StatefulWidget {
  static const String routeName = "crear_historia";
  const CrearHistoriaScreen({super.key});

  @override
  State<CrearHistoriaScreen> createState() => _CrearHistoriaScreenState();
}

class _CrearHistoriaScreenState extends State<CrearHistoriaScreen> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _categoriaController = TextEditingController();
  final TextEditingController _introduccionController = TextEditingController();

  void _abrirEscribir(Map<String, dynamic> historia) {
    final provider = Provider.of<ProjectProvider>(context, listen: false);
    final index = provider.agregarProyecto(historia);

   
    context.pushNamed(
      EscribirHistoriaScreen.routeName,
      extra: {
        'proyectoIndex': index,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Nueva Historia"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _tituloController,
              decoration: InputDecoration(
                labelText: "Título",
                filled: true,
                fillColor: theme.cardColor,
                labelStyle: const TextStyle(color: Colors.white70),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _categoriaController,
              decoration: InputDecoration(
                labelText: "Categoría",
                filled: true,
                fillColor: theme.cardColor,
                labelStyle: const TextStyle(color: Colors.white70),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _introduccionController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: "Introducción",
                filled: true,
                fillColor: theme.cardColor,
                labelStyle: const TextStyle(color: Colors.white70),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final nuevaHistoria = {
                    "titulo": _tituloController.text.isNotEmpty
                        ? _tituloController.text
                        : "Sin título",
                    "categoria": _categoriaController.text.isNotEmpty
                        ? _categoriaController.text
                        : "Sin categoría",
                    "introduccion": _introduccionController.text,
                    "capitulos": [],
                  };
                  _abrirEscribir(nuevaHistoria);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD4AF37),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  "Crear Historia",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:login/providers/project_provider.dart';
import 'package:go_router/go_router.dart';

class EscribirHistoriaScreen extends StatefulWidget {
  static const String routeName = "escribir_historia";
  final int index;

  const EscribirHistoriaScreen({super.key, required this.index});

  @override
  State<EscribirHistoriaScreen> createState() =>
      _EscribirHistoriaScreenState();
}

class _EscribirHistoriaScreenState extends State<EscribirHistoriaScreen> {
  final TextEditingController _contenidoController = TextEditingController();
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _contenidoController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _guardarCapitulo() {
    final provider = Provider.of<ProjectProvider>(context, listen: false);

    if (_contenidoController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No puedes guardar un capítulo vacío")),
      );
      return;
    }

    final nuevoCapitulo = {"contenido": _contenidoController.text.trim()};
    provider.agregarCapitulo(widget.index, nuevoCapitulo);

    _contenidoController.clear();


    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 100,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

    setState(() {});
  }

  void _guardarProyectoYSalir() {
    final provider = Provider.of<ProjectProvider>(context, listen: false);

    if (_contenidoController.text.trim().isNotEmpty) {
      final nuevoCapitulo = {"contenido": _contenidoController.text.trim()};
      provider.agregarCapitulo(widget.index, nuevoCapitulo);
    }

    context.goNamed('proyectos');
  }

  @override
  Widget build(BuildContext context) {
    final proyecto =
        Provider.of<ProjectProvider>(context).proyectos[widget.index];
    final capitulos = proyecto["capitulos"] as List<dynamic>;
    final numeroCapitulo = capitulos.length + 1;

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2C2C3E),
        title: Text(proyecto["titulo"] ?? "Sin título"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [


            /// Editor de capítulo
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: TextField(
                    controller: _contenidoController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: "Escribe el Capítulo $numeroCapitulo...",
                      hintStyle: const TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: const Color(0xFF2C2C3E),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),


            /// Botón de guardar capítulo
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _guardarCapitulo,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A90E2),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Guardar Capítulo $numeroCapitulo",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),
            

            /// Botón para guardar el proyecto y salir
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _guardarProyectoYSalir,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 49, 129, 221),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Guardar Proyecto",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            /// Lista de capítulos
            Expanded(
              flex: 2,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: capitulos.length,
                itemBuilder: (context, index) {
                  final cap = capitulos[index];
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C2C3E),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Capítulo ${index + 1}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          cap["contenido"] ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
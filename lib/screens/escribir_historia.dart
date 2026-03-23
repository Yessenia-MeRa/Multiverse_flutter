import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:login/providers/project_provider.dart';

class EscribirHistoriaScreen extends StatefulWidget {
  final int proyectoIndex;
  final int? capituloIndex; 

  const EscribirHistoriaScreen({
    super.key,
    required this.proyectoIndex,
    this.capituloIndex,
  });

  static const String routeName = "escribir_historia";

  @override
  State<EscribirHistoriaScreen> createState() =>
      _EscribirHistoriaScreenState();
}

class _EscribirHistoriaScreenState extends State<EscribirHistoriaScreen> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _contenidoController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _categoriaController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    final proyecto = Provider.of<ProjectProvider>(context, listen: false)
        .proyectos[widget.proyectoIndex];

    _tituloController.text = proyecto["titulo"] ?? "";
    _categoriaController.text = proyecto["categoria"] ?? "";
    _imageController.text = proyecto["imageUrl"] ?? "";

    // Si se pasa un capítulo específico, cargar su contenido
    if (widget.capituloIndex != null) {
      final capitulos = proyecto["capitulos"] as List<dynamic>;
      if (widget.capituloIndex! < capitulos.length) {
        _contenidoController.text =
            capitulos[widget.capituloIndex!]["contenido"] ?? "";
      }
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _contenidoController.dispose();
    _categoriaController.dispose();
    _imageController.dispose();
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

    // Si es un capítulo existente
    if (widget.capituloIndex != null) {
      provider.proyectos[widget.proyectoIndex]["capitulos"]
          [widget.capituloIndex!] = {"contenido": _contenidoController.text.trim()};
    } else {
      provider.agregarCapitulo(widget.proyectoIndex, {
        "contenido": _contenidoController.text.trim(),
      });
    }

    _contenidoController.clear();
    setState(() {});
  }

  void _guardarProyectoYSalir() {
    final provider = Provider.of<ProjectProvider>(context, listen: false);

    if (_contenidoController.text.trim().isNotEmpty) {
      provider.agregarCapitulo(widget.proyectoIndex, {
        "contenido": _contenidoController.text.trim(),
      });
    }

    provider.actualizarProyecto(widget.proyectoIndex, {
      "titulo": _tituloController.text.isNotEmpty
          ? _tituloController.text
          : "Sin título",
      "categoria": _categoriaController.text.isNotEmpty
          ? _categoriaController.text
          : "Sin categoría",
      "imageUrl": _imageController.text.isNotEmpty ? _imageController.text : "",
    });

    context.pop();
  }

  void _publicarHistoria() async {
    final provider = Provider.of<ProjectProvider>(context, listen: false);

    if (_contenidoController.text.trim().isNotEmpty) {
      provider.agregarCapitulo(widget.proyectoIndex, {
        "contenido": _contenidoController.text.trim(),
      });
      _contenidoController.clear();
    }

    provider.actualizarProyecto(widget.proyectoIndex, {
      "titulo": _tituloController.text.isNotEmpty
          ? _tituloController.text
          : "Sin título",
      "categoria": _categoriaController.text.isNotEmpty
          ? _categoriaController.text
          : "Sin categoría",
      "imageUrl": _imageController.text.isNotEmpty ? _imageController.text : "",
    });

    await provider.publicarProyecto(widget.proyectoIndex);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Historia publicada ✅")),
    );

    setState(() {});
  }

  Widget _campoCard({required Widget child}) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(),
            blurRadius: 6,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final proyecto =
        Provider.of<ProjectProvider>(context).proyectos[widget.proyectoIndex];
    final capitulos = proyecto["capitulos"] as List<dynamic>;
    final numeroCapitulo = capitulos.length + 1;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Escribir Historia"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              _campoCard(
                child: TextField(
                  controller: _tituloController,
                  decoration: const InputDecoration(
                    hintText: "Título de la historia",
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              _campoCard(
                child: TextField(
                  controller: _imageController,
                  decoration: const InputDecoration(
                    hintText: "URL de la imagen de portada",
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),

              _campoCard(
                child: TextField(
                  controller: _categoriaController,
                  decoration: const InputDecoration(
                    hintText: "Categoría",
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),

              _campoCard(
                child: SizedBox(
                  height: 250,
                  child: TextField(
                    controller: _contenidoController,
                    keyboardType: TextInputType.multiline,
                    expands: true,
                    maxLines: null,
                    minLines: null,
                    decoration: InputDecoration(
                      hintText: "Escribe el Capítulo $numeroCapitulo...",
                      hintStyle: const TextStyle(color: Colors.white54),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: _guardarCapitulo,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD4AF37),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  "Guardar Capítulo $numeroCapitulo",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),

              const SizedBox(height: 8),

              ElevatedButton(
                onPressed: _publicarHistoria,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  "Publicar / Actualizar Historia",
                  style: TextStyle(color: Colors.white),
                ),
              ),

              const SizedBox(height: 8),

              ElevatedButton(
                onPressed: _guardarProyectoYSalir,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD4AF37),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  "Guardar Proyecto",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),

              const SizedBox(height: 20),

              // Lista de capítulos
              ...capitulos.asMap().entries.map((entry) {
                final index = entry.key;
                final cap = entry.value;

                return GestureDetector(
                  onTap: () {
                    // Abrir capítulo existente
                    context.pushNamed(
                      "capitulo",
                      extra: {
                        'proyectoIndex': widget.proyectoIndex,
                        'capituloIndex': index,
                      },
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(12),
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
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
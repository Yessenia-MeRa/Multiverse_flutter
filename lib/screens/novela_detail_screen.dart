import 'package:flutter/material.dart';
import 'package:login/core/data/library_data.dart';

class NovelDetailScreen extends StatelessWidget {
  static const String routeName = "detail";

  final Map<String, dynamic> historia;

  const NovelDetailScreen({super.key, required this.historia});

  @override
  Widget build(BuildContext context) {
    final capitulos = historia['capitulos'] as List<dynamic>? ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(historia['titulo'] ?? "Sin título"),
        backgroundColor: const Color(0xFF2C2C3E),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: historia['imageUrl'] != null && historia['imageUrl'] != ""
                  ? Image.network(
                      historia['imageUrl'],
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _placeholderImage();
                      },
                    )
                  : _placeholderImage(),
            ),
            const SizedBox(height: 16),

            // Título
            Text(
              historia['titulo'] ?? "Sin título",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 8),

            // Categoría
            Text(
              historia['categoria'] ?? "Sin categoría",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 12),

            // Introducción
            Text(
              historia['introduccion'] ?? "",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white54, fontSize: 16),
            ),
            const SizedBox(height: 16),

            // Botón agregar/quitar de biblioteca
            Center(
              child: ValueListenableBuilder<List<Map<String, dynamic>>>(
                valueListenable: LibraryData.favoritos,
                builder: (context, favoritos, _) {
                  final isFavorito = favoritos.contains(historia);
                  return ElevatedButton.icon(
                    onPressed: () {
                      if (isFavorito) {
                        LibraryData.removeBook(historia);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Eliminado de Biblioteca ❌"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        LibraryData.addBook(historia);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Agregado a Biblioteca ✅"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    icon: Icon(isFavorito ? Icons.delete : Icons.favorite),
                    label: Text(isFavorito
                        ? "Quitar de Biblioteca"
                        : "Agregar a Biblioteca"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF283593),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      textStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // Lista de capítulos
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: capitulos.length,
              itemBuilder: (context, index) {
                final cap = capitulos[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
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
                        cap['contenido'] ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholderImage() {
    return Container(
      height: 300,
      color: Colors.grey[800],
      child: const Center(
        child: Icon(Icons.broken_image, color: Colors.white, size: 50),
      ),
    );
  }
}
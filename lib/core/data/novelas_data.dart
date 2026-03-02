class Novela {
  final String titulo;
  final String imageUrl;
  final String introduccion;
  final String categoria;
  final List<Map<String, String>> capitulos;

  Novela({
    required this.titulo,
    required this.imageUrl,
    required this.introduccion,
    required this.categoria,
    required this.capitulos,
  });
}

class NovelasData {
  static const List<String> categorias = [
    "Romance",
    "Misterio",
    "Fantasía",
    "Aventura",
    "Ciencia ficción",
    "Drama",
    "Thriller",
  ];

  static final List<Novela> novelas = List.generate(14, (index) {
    final categoria = categorias[index % categorias.length];
    return Novela(
      titulo: "Novela ${index + 1}",
      imageUrl: "https://picsum.photos/200/300?random=${index + 1}",
      introduccion: "Esta es la introducción de Novela ${index + 1}",
      categoria: categoria,
      capitulos: List.generate(
        3,
        (i) => {"contenido": "Capítulo ${i + 1} de Novela ${index + 1}"},
      ),
    );
  });
}
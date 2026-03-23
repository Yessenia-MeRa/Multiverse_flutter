import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login/core/data/novelas_data.dart';
import 'package:login/core/widgets/novela_card.dart';
import 'package:login/core/widgets/custom_bottom_nav.dart';
import 'package:login/screens/novela_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:login/providers/project_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = "home";

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProjectProvider>(context);
    final theme = Theme.of(context);

    // Combina novelas de datos y proyectos del usuario
    final todasLasNovelas = [
      ...NovelasData.novelas.map((n) => {
            "titulo": n.titulo,
            "categoria": n.categoria,
            "introduccion": n.introduccion,
            "imageUrl": n.imageUrl,
            "capitulos": n.capitulos,
          }),
      ...provider.proyectos
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Título
                Text(
                  "Multiverse",
                  style: theme.textTheme.headlineLarge?.copyWith(
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 24),

                // Subtítulo
                Text(
                  "Historias que no podrás soltar",
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 24),

                // Lista horizontal de novelas
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: todasLasNovelas.length >= 6
                        ? 6
                        : todasLasNovelas.length,
                    itemBuilder: (context, index) {
                      final novela = todasLasNovelas[index];

                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: NovelaCard(
                          titulo: novela['titulo'] ?? "Sin título",
                          imageUrl: novela['imageUrl'] ?? "",
                          grande: true,
                          onTap: () {
                            context.pushNamed(
                              NovelDetailScreen.routeName,
                              extra: {
                                ...novela,
                                'proyectoIndex': index, // agregado para capítulos
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 28),

                // Sección "Las mejores selecciones"
                Text(
                  "Las mejores selecciones para ti",
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 12),

                // Grid de novelas
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: todasLasNovelas.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.65,
                  ),
                  itemBuilder: (context, index) {
                    final novela = todasLasNovelas[index];

                    return NovelaCard(
                      titulo: novela['titulo'] ?? "Sin título",
                      imageUrl: novela['imageUrl'] ?? "",
                      grande: false,
                      onTap: () {
                        context.pushNamed(
                          NovelDetailScreen.routeName,
                          extra: {
                            ...novela,
                            'proyectoIndex': index, // necesario para capítulos
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: const CustomBottomNav(currentIndex: 0),
    );
  }
}
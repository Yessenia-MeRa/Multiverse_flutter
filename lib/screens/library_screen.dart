import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login/core/widgets/novela_card.dart';
import 'package:login/core/widgets/custom_bottom_nav.dart';
import 'package:login/screens/home_screen.dart';
import 'package:login/screens/novela_detail_screen.dart';
import 'package:login/core/data/library_data.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});
  static const String routeName = "library";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); 

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, 

      appBar: AppBar(
        title: const Text("Biblioteca"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.goNamed(HomeScreen.routeName),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ValueListenableBuilder<List<Map<String, dynamic>>>(
          valueListenable: LibraryData.favoritos,
          builder: (context, favoritos, _) {
            if (favoritos.isEmpty) {
              return Center(
                child: Text(
                  "No tienes novelas en tu biblioteca",
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.white70,
                  ),
                ),
              );
            }

            return GridView.builder(
              itemCount: favoritos.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                final novela = favoritos[index];

                final imageUrl = novela['imageUrl'] ?? '';

                return NovelaCard(
                  titulo: novela['titulo'] ?? 'Sin título',
                  imageUrl: imageUrl,
                  onTap: () {
                    context.pushNamed(
                      NovelDetailScreen.routeName,
                      extra: novela,
                    );
                  },
                );
              },
            );
          },
        ),
      ),

      bottomNavigationBar: const CustomBottomNav(currentIndex: 2),
    );
  }
}
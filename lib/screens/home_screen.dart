import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login/core/data/novelas_data.dart';
import 'package:login/core/widgets/novela_card.dart';
import 'package:login/core/widgets/custom_bottom_nav.dart';
import 'package:login/screens/novela_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = "home";

  @override
  Widget build(BuildContext context) {
    final categoriasDestacadas = ["Romance", "Misterio", "Fantasía"];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Multiverse",
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Historias que no podrás soltar",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),

                // Categorías horizontales
                SizedBox(
                  height: 45,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: categoriasDestacadas
                        .map(
                          (cat) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 10),
                              decoration: BoxDecoration(
                                color: const Color(0xFF283593),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Text(
                                cat,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),

                const SizedBox(height: 24),

                // Novelas destacadas
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: NovelasData.novelas.length >= 6
                        ? 6
                        : NovelasData.novelas.length,
                    itemBuilder: (context, index) {
                      final novela = NovelasData.novelas[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: NovelaCard(
                          titulo: novela.titulo,
                          imageUrl: novela.imageUrl,
                          grande: true,
                          onTap: () {
                            context.pushNamed(
                              NovelDetailScreen.routeName,
                              extra: novela,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 28),
                const Text(
                  "Las mejores selecciones para ti",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),

                // Grid de novelas
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: NovelasData.novelas.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.65,
                  ),
                  itemBuilder: (context, index) {
                    final novela = NovelasData.novelas[index];
                    return NovelaCard(
                      titulo: novela.titulo,
                      imageUrl: novela.imageUrl,
                      grande: false,
                      onTap: () {
                        context.pushNamed(
                          NovelDetailScreen.routeName,
                          extra: novela,
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
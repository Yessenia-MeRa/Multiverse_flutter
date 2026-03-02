import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login/core/data/novelas_data.dart';
import 'package:login/core/widgets/novela_card.dart';
import 'package:login/core/widgets/custom_bottom_nav.dart';
import 'package:login/screens/home_screen.dart';
import 'package:login/screens/novela_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  static const String routeName = "search";

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  late List<Novela> _filteredResultados;

  @override
  void initState() {
    super.initState();
    _filteredResultados = List.from(NovelasData.novelas);
  }

  void _filtrar(String query) {
    setState(() {
      _filteredResultados = NovelasData.novelas
          .where((novela) =>
              novela.titulo.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mainCategorias = ["Romance", "Misterio", "Fantasía"];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Buscar"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.goNamed(HomeScreen.routeName),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            // Buscador
            TextField(
              controller: _controller,
              onChanged: _filtrar,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Buscar historias...",
                hintStyle: const TextStyle(color: Colors.white54),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                filled: true,
                fillColor: const Color(0xFF1A237E),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),


            // Categorías horizontales
            SizedBox(
              height: 45,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ...mainCategorias.map((cat) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: _CategoryChip(label: cat, onTap: () {
                          setState(() {
                            _filteredResultados = NovelasData.novelas
                                .where((novela) => novela.categoria == cat)
                                .toList();
                          });
                        }),
                      )),
                  _CategoryChip(
                    label: "Todo",
                    icon: Icons.list,
                    onTap: () {
                      setState(() {
                        _filteredResultados = List.from(NovelasData.novelas);
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            

            // Grid de resultados
            Expanded(
              child: _filteredResultados.isEmpty
                  ? const Center(
                      child: Text(
                        "No se encontraron novelas",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : GridView.builder(
                      itemCount: _filteredResultados.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (context, index) {
                        final novela = _filteredResultados[index];
                        return NovelaCard(
                          titulo: novela.titulo,
                          imageUrl: novela.imageUrl,
                          onTap: () {
                            context.pushNamed(
                              NovelDetailScreen.routeName,
                              extra: novela,
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 1),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final IconData? icon;

  const _CategoryChip({required this.label, this.onTap, this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF283593),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white, size: 18),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
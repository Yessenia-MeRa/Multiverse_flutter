import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../screens/home_screen.dart';
import '../../screens/search_screen.dart';
import '../../screens/library_screen.dart';
import '../../screens/write_screen.dart';
import '../../screens/profile_screen.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  const CustomBottomNav({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,

      backgroundColor: theme.bottomNavigationBarTheme.backgroundColor,
      selectedItemColor: theme.primaryColor, 
      unselectedItemColor: Colors.white70,

      onTap: (index) {
        switch (index) {
          case 0:
            context.goNamed(HomeScreen.routeName);
            break;
          case 1:
            context.goNamed(SearchScreen.routeName);
            break;
          case 2:
            context.goNamed(LibraryScreen.routeName);
            break;
          case 3:
            context.goNamed(WriteScreen.routeName);
            break;
          case 4:
            context.goNamed(ProfileScreen.routeName);
            break;
        }
      },

      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Inicio",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: "Buscar",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.collections_bookmark),
          label: "Biblioteca",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.create),
          label: "Escribir",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Perfil",
        ),
      ],
    );
  }
}
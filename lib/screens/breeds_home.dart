import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peludos/screens/profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:peludos/providers/theme_provider.dart';

import 'breeds_screen.dart';
import 'favorites_screen.dart';

class BreedsHome extends StatefulWidget {
  static const String routeName = '/home';
  const BreedsHome({super.key});

  @override
  State<BreedsHome> createState() => _BreedsHomeState();
}

class _BreedsHomeState extends State<BreedsHome> {
  int _currentIndex = 0;
  final List<Widget> _screens = const [
    BreedsScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];
  final List<String> titles = ['Razas', 'Favoritos', 'Perfil'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
  backgroundColor: const Color(0xFF4DD0E1),          // turquesa suave
  elevation: 0,
  title: Text(
    titles[_currentIndex],
    style: GoogleFonts.pacifico(                      // fuente Google
      fontSize: 26,
      color: Colors.white,
    ),
  ),
  actions: [
    IconButton(
      icon: Icon(
        context.read<ThemeProvider>().mode == ThemeMode.dark
            ? Icons.wb_sunny
            : Icons.nightlight_round,
      ),
      onPressed: () => context.read<ThemeProvider>().toggle(),
    ),
  ],
),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: 'Razas'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favoritos'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
        onTap: (i) => setState(() => _currentIndex = i),
      ),
    );
  }
}

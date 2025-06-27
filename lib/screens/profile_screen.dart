import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import 'splash_screen.dart';

/// Pantalla de perfil responsive al estilo Peludos.
class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProv = context.watch<ThemeProvider>();
    final theme = Theme.of(context);
    final double headerHeight = (MediaQuery.of(context).size.height * 0.35).clamp(260, 380).toDouble();
    (MediaQuery.of(context).size.width * 0.18).clamp(60, 90).toDouble();

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          // Encabezado colapsable con imagen y avatar
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            expandedHeight: headerHeight,
            floating: false,
            pinned: false, 
            stretch: true,
    
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
              ],
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/logo.jpg',
                    fit: BoxFit.cover,
                  ),   
                ],
              ),
            ),
          ),
          // Contenido
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Erick Demo',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontFamily: GoogleFonts.pacifico().fontFamily,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'erickespinoza@peludos.app',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.hintColor,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Tarjeta ajustes
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 580),
                    child: Card(
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SwitchListTile.adaptive(
                            title: const Text('Modo oscuro'),
                            value: themeProv.mode == ThemeMode.dark,
                            onChanged: (_) => themeProv.toggle(),
                            secondary: Icon(
                              themeProv.mode == ThemeMode.dark
                                  ? Icons.nightlight_round
                                  : Icons.wb_sunny,
                            ),
                          ),
                          const Divider(height: 0),
                          ListTile(
                            leading: const Icon(Icons.logout),
                            title: const Text('Cerrar sesión'),
                            onTap: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                SplashScreen.routeName,
                                (route) => false,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

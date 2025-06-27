// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'providers/dog_provider.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';
import 'screens/breeds_home.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DogProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const PeludosApp(),
    ),
  );
}

class PeludosApp extends StatelessWidget {
  const PeludosApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProv = context.watch<ThemeProvider>();

    return MaterialApp(
      title: 'Peludos',
      debugShowCheckedModeBanner: false,
      themeMode: themeProv.mode,          
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (_) => const SplashScreen(),
        BreedsHome.routeName:    (_) => const BreedsHome(),
      },
    );
  }
}

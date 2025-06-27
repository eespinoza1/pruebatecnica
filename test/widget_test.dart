

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:peludos/main.dart';               // PeludosApp
import 'package:peludos/providers/dog_provider.dart';
import 'package:peludos/providers/theme_provider.dart';

void main() {
  testWidgets('Splash → Home (Razas/Favoritos) navigation smoke test',
      (WidgetTester tester) async {
    // Montar la app con todos los providers necesarios
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => DogProvider()),
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
        child: const PeludosApp(), // raíz que incluye themeMode
      ),
    );

    // Splash: debe mostrar el texto 'Peludos'
    expect(find.text('Peludos'), findsOneWidget);

    // Avanzar 3 s y dejar que navegue a Home
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    // BottomNavigationBar y tabs
    expect(find.byType(BottomNavigationBar), findsOneWidget);
    expect(find.text('Razas'), findsOneWidget);
    expect(find.text('Favoritos'), findsOneWidget);

    // Campo de búsqueda presente en la pestaña Razas
    expect(find.byType(TextField), findsOneWidget);

    // Cambiar a Favoritos
    await tester.tap(find.text('Favoritos'));
    await tester.pumpAndSettle();

    // Sin favoritos aún
    expect(find.text('No hay favoritos aún'), findsOneWidget);
  });
}

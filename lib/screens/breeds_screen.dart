// lib/screens/breeds_screen.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:peludos/widgets/loading_indicator.dart';
import 'package:provider/provider.dart';
import '../providers/dog_provider.dart';
import '../widgets/dog_card.dart';
import '../models/dog_breed.dart';
import 'breed_detail_screen.dart';

class BreedsScreen extends StatefulWidget {
  const BreedsScreen({super.key});

  // Colores pastel suavizados pero suficientemente intensos
  static const List<Color> pastelColors = [
    Color(0xFF9DD6F3), // azul
    Color(0xFFFFD8B1),// amarillo
    Color(0xFFB4E2B5), // verde
    Color(0xFFF6AFC3), // rosa
    Color(0xFFC5B4F0), // lila
  ];

  @override
  State<BreedsScreen> createState() => _BreedsScreenState();
}

class _BreedsScreenState extends State<BreedsScreen> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query, DogProvider prov) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      prov.search(query);
    });
    setState(() {}); // para refrescar el suffixIcon
  }

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<DogProvider>();
    final allBreeds = prov.allBreeds; // asegúrate de tener getter en el provider

    if (prov.status == Status.loading) {
      return const LoadingIndicator();
    }

    if (prov.status == Status.error) {
      return Center(child: Text('Error: ${prov.errorMessage}'));
    }

    return Column(
      children: [
        // Barra de búsqueda con Autocomplete integrado (Flutter nativo)
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Autocomplete<DogBreed>(
            optionsBuilder: (TextEditingValue value) {
              if (value.text.isEmpty) return const Iterable<DogBreed>.empty();
              return allBreeds.where((b) =>
                  b.name.toLowerCase().contains(value.text.toLowerCase()));
            },
            displayStringForOption: (b) => b.name,
            fieldViewBuilder: (context, textCtrl, focusNode, onSubmit) {
              // Reemplazamos el controlador interno
              _controller.text = textCtrl.text;
              _controller.selection = textCtrl.selection;
              textCtrl.addListener(() {
                if (_controller.text != textCtrl.text) {
                  _controller.text = textCtrl.text;
                }
              });
     return TextField(
  controller: textCtrl,
  focusNode: focusNode,
  decoration: InputDecoration(
    hintText: 'Buscar por raza',
    prefixIcon: const Icon(Icons.search),
    suffixIcon: textCtrl.text.isNotEmpty
        ? IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              textCtrl.clear();
              prov.search('');
              setState(() {});
            },
          )
        : null,
    // 👉 bordes personalizados
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade400), // gris claro
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade600, width: 2), // gris al obtener focus
    ),
  ),
  onChanged: (q) => _onSearchChanged(q, prov),
);
            },
            onSelected: (selection) {
              _controller.text = selection.name;
              prov.search(selection.name);
              FocusScope.of(context).unfocus();
            },
          ),
        ),

        Expanded(
          child: ListView.builder(
            itemCount: prov.breeds.length,
            itemBuilder: (_, i) {
              final breed = prov.breeds[i];
              final isFav = prov.favorites.contains(breed);
              final bgColor =
                  BreedsScreen.pastelColors[i % BreedsScreen.pastelColors.length];
              return DogCard(
                breed: breed,
                isFavorite: isFav,
                backgroundColor: bgColor,
                onFavoriteToggle: () => prov.toggleFavorite(breed),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => BreedDetailScreen(breed: breed),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

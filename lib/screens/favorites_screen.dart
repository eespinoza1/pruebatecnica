import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/dog_provider.dart';
import '../widgets/dog_card.dart';
import '../models/dog_breed.dart';
import 'breed_detail_screen.dart';
import 'breeds_screen.dart'; // para obtener pastelColors

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prov = context.read<DogProvider>();
    final favs = context.watch<DogProvider>().favorites;

    if (favs.isEmpty) {
      return const Center(
        child: Text(
          'No hay favoritos aún',
          style: TextStyle(fontSize: 18, color: Colors.black54),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: favs.length,
      itemBuilder: (_, i) {
        final DogBreed breed = favs[i];
        // ciclo de colores pastel igual que en BreedsScreen
        final Color bgColor = BreedsScreen.pastelColors[
          i % BreedsScreen.pastelColors.length
        ];
        return DogCard(
          breed: breed,
          isFavorite: true,
          backgroundColor: bgColor,
          onFavoriteToggle: () => prov.toggleFavorite(breed),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => BreedDetailScreen(breed: breed),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import '../models/dog_breed.dart';

/// Pantalla de detalle profesional para mostrar la información de una raza canina.
/// Inspirada en tendencias de diseño móvil vistas en Pinterest y Dribbble.
class BreedDetailScreen extends StatelessWidget {
  final DogBreed breed;
  const BreedDetailScreen({Key? key, required this.breed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App bar colapsable con Hero + overlay degradado
          SliverAppBar(
            title: Text(breed.name),
            expandedHeight: 300,
            pinned: true,
            stretch: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.blurBackground,
                StretchMode.zoomBackground,
              ],
              background: Hero(
                tag: breed.imageUrl,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      breed.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Image.asset(
                        'assets/images/placeholder.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Gradiente para mejorar la legibilidad del título
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black45],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Contenido principal
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _InfoRow(
                        icon: Icons.group_work_outlined,
                        label: 'Grupo',
                        value: breed.breed_group,
                      ),
                      const SizedBox(height: 12),
                      _InfoRow(
                        icon: Icons.emoji_emotions_outlined,
                        label: 'Temperamento',
                        value: breed.temperament,
                      ),
                      const SizedBox(height: 12),
                      _InfoRow(
                        icon: Icons.hourglass_bottom,
                        label: 'Esperanza de vida',
                        value: breed.lifeSpan,
                      ),
                      const SizedBox(height: 12),
                      _InfoRow(
                        icon: Icons.public,
                        label: 'Origen',
                        value: breed.origin,
                      ),
                      const SizedBox(height: 16),
                
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: breed.temperament
                            .split(',')
                            .map((temp) => Chip(
                                  label: Text(temp.trim()),
                                  backgroundColor:
                                      Color.fromARGB(255, 196, 236, 245),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Color.fromARGB(255, 80, 205, 236)),
        const SizedBox(width: 12),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: theme.textTheme.bodyLarge,
              children: [
                TextSpan(
                  text: '$label: ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: value),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

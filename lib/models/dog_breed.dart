class DogBreed {
  final int id;
  final String name;
  final String temperament;
  final String breed_group; // Not used in the model, but present in API
  final String lifeSpan;
  final String origin;
  final String imageUrl;

  DogBreed({
    required this.id,
    required this.name,
    required this.temperament,
    required this.breed_group, 
    required this.lifeSpan,
    required this.origin,
    required this.imageUrl,
  });

  factory DogBreed.fromJson(Map<String, dynamic> json) {
    // Attempt to get image URL; fallback to reference_image_id or placeholder
    String url;
    if (json['image'] != null && json['image']['url'] != null) {
      url = json['image']['url'];
    } else if (json['reference_image_id'] != null) {
      url = 'https://cdn2.thedogapi.com/images/${json['reference_image_id']}.jpg';
    } else {
      url = 'https://via.placeholder.com/150';
    }

    return DogBreed(
      id: json['id'],
      name: json['name'] ?? '',

      temperament: json['temperament'] ?? '',
       breed_group: json['breed_group'] ?? '',
      lifeSpan: json['life_span'] ?? '',
      origin: json['origin'] ?? '',
      imageUrl: url,
    );
  }
}

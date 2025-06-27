import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/dog_breed.dart';

class DogApiService {
  final String _baseUrl = 'https://api.thedogapi.com/v1/breeds';

  Future<List<DogBreed>> fetchBreeds() async {
    final uri = Uri.parse(_baseUrl);
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Error al cargar razas: ${response.statusCode}');
    }
    final List data = json.decode(response.body);
    return data.map((e) => DogBreed.fromJson(e)).toList();
  }
}

import 'package:flutter/material.dart';
import '../models/dog_breed.dart';
import '../services/dog_api_service.dart';

enum Status { idle, loading, success, error }

class DogProvider extends ChangeNotifier {
  final DogApiService _api = DogApiService();
  List<DogBreed> _allBreeds = [];
  List<DogBreed> _filtered = [];
  final List<DogBreed> _favorites = [];
  Status status = Status.idle;
  String? errorMessage;
List<DogBreed> get allBreeds => _allBreeds;

  List<DogBreed> get breeds => _filtered;
  List<DogBreed> get favorites => _favorites;

  DogProvider() {
    fetchBreeds();
  }

  Future<void> fetchBreeds() async {
    status = Status.loading;
    notifyListeners();
    try {
      _allBreeds = await _api.fetchBreeds();
      _filtered = List.from(_allBreeds);
      status = Status.success;
    } catch (e) {
      errorMessage = e.toString();
      status = Status.error;
    }
    notifyListeners();
  }

  void search(String query) {
    if (query.isEmpty) {
      _filtered = List.from(_allBreeds);
    } else {
      _filtered = _allBreeds
          .where((b) => b.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void toggleFavorite(DogBreed breed) {
    if (_favorites.contains(breed)) {
      _favorites.remove(breed);
    } else {
      _favorites.add(breed);
    }
    notifyListeners();
  }
}

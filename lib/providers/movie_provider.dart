import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import '../services/api_service.dart';

class MovieProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<MovieModel> _popularMovies = [];
  List<MovieModel> _topRatedMovies = [];
  List<MovieModel> _searchResults = [];

  bool _isLoading = false;

  List<MovieModel> get popularMovies => _popularMovies;
  List<MovieModel> get topRatedMovies => _topRatedMovies;
  List<MovieModel> get searchResults => _searchResults;
  bool get isLoading => _isLoading;

  Future<void> fetchPopularMovies() async {
    _isLoading = true;
    notifyListeners();

    try {
      _popularMovies = await _apiService.getPopularMovies();
    } catch (e) {
      print('Error fetching popular movies: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchTopRatedMovies() async {
    _isLoading = true;
    notifyListeners();

    try {
      _topRatedMovies = await _apiService.getTopRatedMovies();
    } catch (e) {
      print('Error fetching top-rated movies: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      _searchResults = [];
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      _searchResults = await _apiService.searchMovies(query);
    } catch (e) {
      print('Error searching movies: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearSearch() {
    _searchResults = [];
    notifyListeners();
  }
}

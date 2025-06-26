// providers/movie_provider.dart

import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import '../services/api_service.dart';

class MovieProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<MovieModel> _popularMovies = [];
  List<MovieModel> _topRatedMovies = [];
  List<MovieModel> _searchResults = [];

  bool _isLoading = false;
  String? _errorMessage;

  List<MovieModel> get popularMovies => _popularMovies;
  List<MovieModel> get topRatedMovies => _topRatedMovies;
  List<MovieModel> get searchResults => _searchResults;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  Future<void> fetchPopularMovies() async {
    _setLoading(true);
    _setError(null);

    try {
      _popularMovies = await _apiService.getPopularMovies();
    } catch (e) {
      _setError('Failed to load popular movies. Please check your internet.');
      print('Error: $e');
    }

    _setLoading(false);
  }

  Future<void> fetchTopRatedMovies() async {
    _setLoading(true);
    _setError(null);

    try {
      _topRatedMovies = await _apiService.getTopRatedMovies();
    } catch (e) {
      _setError('Failed to load top-rated movies.');
      print('Error: $e');
    }

    _setLoading(false);
  }

  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      _searchResults = [];
      notifyListeners();
      return;
    }

    _setLoading(true);
    _setError(null);

    try {
      _searchResults = await _apiService.searchMovies(query);
    } catch (e) {
      _setError('Search failed. Try again later.');
      print('Error: $e');
    }

    _setLoading(false);
  }

  void clearSearch() {
    _searchResults = [];
    _setError(null);
    notifyListeners();
  }
}

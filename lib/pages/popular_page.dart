import 'package:flutter/material.dart';
import 'package:movie_listing_app/pages/movie_category_page.dart';
import 'package:movie_listing_app/services/api_service.dart';

class PopularPage extends StatelessWidget {
  const PopularPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MovieCategoryPage(
      title: "Popular Movies",
      fetchMovies: apiService.value.getPopularMovies(),
      icon: Icon(Icons.trending_up),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movie_listing_app/pages/movie_category_page.dart';
import 'package:movie_listing_app/services/api_service.dart';

class TopRatedPage extends StatelessWidget {
  const TopRatedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MovieCategoryPage(
      title: "Top Rated Movies",
      fetchMovies: apiService.value.getTopRatedMovies(),
      icon: Icon(Icons.star),
    );
  }
}

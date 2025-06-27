import 'package:flutter/material.dart';
import 'package:movie_listing_app/models/movie_model.dart';

class MovieDetailPage extends StatelessWidget {
  final MovieModel movie;

  const MovieDetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.network(movie.fullPosterUrl, width: 200)),
            const SizedBox(height: 16),
            Text(
              movie.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _getRatingIcon(movie.rating),
                const SizedBox(width: 8),
                Text(
                  '${movie.rating.toStringAsFixed(1)} / 10 - TMDb',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              movie.overview.isNotEmpty ? movie.overview : "No description.",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Icon _getRatingIcon(double rating) {
    if (rating >= 8.0) {
      return const Icon(Icons.star, color: Colors.green);
    } else if (rating >= 5.0) {
      return const Icon(Icons.star_half, color: Colors.amber);
    } else {
      return const Icon(Icons.star_border, color: Colors.red);
    }
  }
}

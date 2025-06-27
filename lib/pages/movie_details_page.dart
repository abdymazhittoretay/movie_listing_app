import 'package:flutter/material.dart';
import 'package:movie_listing_app/models/movie_model.dart';

class MovieDetailPage extends StatelessWidget {
  final MovieModel movie;

  const MovieDetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 64.0,
            top: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.network(
                  movie.fullPosterUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;

                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 100),
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                movie.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _getRatingIcon(movie.rating),
                  const SizedBox(width: 8),
                  Text(
                    '${movie.rating.toStringAsFixed(1)} / 10 - TMDb',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const Divider(height: 32.0, thickness: 1.3, color: Colors.black),
              Row(
                children: [
                  Text(
                    "Description:",
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                textAlign: TextAlign.justify,
                movie.overview.isNotEmpty ? movie.overview : "No description.",
                style: const TextStyle(fontSize: 18.0),
              ),
            ],
          ),
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

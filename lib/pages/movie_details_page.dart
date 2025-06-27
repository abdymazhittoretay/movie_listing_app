import 'package:flutter/material.dart';
import 'package:movie_listing_app/models/movie_model.dart';
import 'package:movie_listing_app/utils/rating_utils.dart';

class MovieDetailPage extends StatelessWidget {
  final MovieModel movie;

  const MovieDetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.movie),
            const SizedBox(width: 8.0),
            Flexible(child: Text(movie.title, overflow: TextOverflow.ellipsis)),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 16.0,
            bottom: 8.0,
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
                "${movie.title}${movie.releaseDate.isNotEmpty ? ", ${movie.releaseDate.substring(0, 4)}" : ""}",
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
                  getRatingIcon(movie.rating),
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
              const SizedBox(height: 32.0),
              Text(
                "Thanks to The Movie Database (TMDb) for the data.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

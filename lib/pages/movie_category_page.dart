import 'package:flutter/material.dart';
import 'package:movie_listing_app/models/movie_model.dart';

class MovieCategoryPage extends StatefulWidget {
  final String title;
  final Future<List<MovieModel>> fetchMovies;

  const MovieCategoryPage({
    super.key,
    required this.title,
    required this.fetchMovies,
  });

  @override
  State<MovieCategoryPage> createState() => _MovieCategoryPageState();
}

class _MovieCategoryPageState extends State<MovieCategoryPage> {
  late Future<List<MovieModel>> _fetchedMovies;

  @override
  void initState() {
    super.initState();
    _fetchedMovies = widget.fetchMovies;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: FutureBuilder<List<MovieModel>>(
        future: _fetchedMovies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.black87),
            );
          }

          if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("No data received."));
          }

          final List<MovieModel> movies = snapshot.data!;

          if (movies.isEmpty) {
            return const Center(child: Text("Movie list is empty!"));
          }

          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final MovieModel movie = movies[index];
              return ListTile(
                title: Text(movie.title),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _getRatingIcon(movie.rating),
                    SizedBox(width: 4.0),
                    Text("${movie.rating.toStringAsFixed(1)} - TMDb"),
                  ],
                ),
              );
            },
          );
        },
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

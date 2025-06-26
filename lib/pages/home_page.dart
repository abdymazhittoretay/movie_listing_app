import 'package:flutter/material.dart';
import 'package:movie_listing_app/models/movie_model.dart';
import 'package:movie_listing_app/services/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<MovieModel>> popularMovies;

  @override
  void initState() {
    super.initState();
    popularMovies = apiService.value.getPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: FutureBuilder<List<MovieModel>>(
        future: popularMovies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
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
                subtitle: Text(movie.rating.toStringAsFixed(1)),
              );
            },
          );
        },
      ),
    );
  }
}

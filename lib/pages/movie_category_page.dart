import 'package:flutter/material.dart';
import 'package:movie_listing_app/models/movie_model.dart';
import 'package:movie_listing_app/widgets/bookmark_button_actions.dart';
import 'package:movie_listing_app/widgets/my_listview_widget.dart';

class MovieCategoryPage extends StatefulWidget {
  final String title;
  final Future<List<MovieModel>> fetchMovies;
  final Icon icon;

  const MovieCategoryPage({
    super.key,
    required this.title,
    required this.fetchMovies,
    required this.icon,
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
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [widget.icon, SizedBox(width: 8.0), Text(widget.title)],
        ),
        centerTitle: true,
        actions: [BookmarkButtonActions()],
      ),
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

          return MyListviewWidget(movies: movies);
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movie_listing_app/models/movie_model.dart';
import 'package:movie_listing_app/pages/movie_details_page.dart';
import 'package:movie_listing_app/utils/rating_utils.dart';

class MyListviewWidget extends StatelessWidget {
  const MyListviewWidget({super.key, required this.movies});

  final List<MovieModel> movies;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final MovieModel movie = movies[index];
        return ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailPage(movie: movie),
              ),
            );
          },
          title: Text(movie.title),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              getRatingIcon(movie.rating),
              SizedBox(width: 4.0),
              Text("${movie.rating.toStringAsFixed(1)} - TMDb"),
            ],
          ),
        );
      },
    );
  }
}

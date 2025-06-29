import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movie_listing_app/models/movie_model.dart';

class WatchLaterButton extends StatelessWidget {
  final MovieModel movie;
  final Color color;
  final double size;

  const WatchLaterButton({
    super.key,
    required this.movie,
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final favoritesBox = Hive.box<MovieModel>('watchLaterBox');
    return ValueListenableBuilder(
      valueListenable: favoritesBox.listenable(),
      builder: (context, Box<MovieModel> box, _) {
        final isSaved = box.values.any((m) => m.id == movie.id);
        return IconButton(
          onPressed: () {
            if (isSaved) {
              box.delete(movie.id);
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.black87,
                    content: Center(
                      child: Text(
                        "Removed from Watch Later",
                        style: TextStyle(),
                      ),
                    ),
                    duration: Duration(seconds: 1),
                  ),
                );
            } else {
              box.put(movie.id, movie);
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.black87,
                    content: Center(child: Text("Added to Watch Later")),
                    duration: Duration(seconds: 1),
                  ),
                );
            }
          },
          icon: Icon(
            isSaved ? Icons.bookmark : Icons.bookmark_add_outlined,
            color: color,
            size: size,
          ),
        );
      },
    );
  }
}

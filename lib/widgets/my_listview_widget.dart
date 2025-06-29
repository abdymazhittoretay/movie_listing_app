import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_listing_app/models/movie_model.dart';
import 'package:movie_listing_app/pages/movie_details_page.dart';
import 'package:movie_listing_app/utils/rating_utils.dart';
import 'package:movie_listing_app/widgets/watch_later_button.dart';

class MyListviewWidget extends StatefulWidget {
  const MyListviewWidget({super.key, required this.movies, this.onMovieTap});

  final List<MovieModel> movies;
  final void Function(MovieModel)? onMovieTap;

  @override
  State<MyListviewWidget> createState() => _MyListviewWidgetState();
}

class _MyListviewWidgetState extends State<MyListviewWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.movies.length,
      itemBuilder: (context, index) {
        final MovieModel movie = widget.movies[index];
        return InkWell(
          onTap: () {
            if (widget.onMovieTap != null) {
              widget.onMovieTap!(movie);
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailPage(movie: movie),
              ),
            ).then((_) {
              setState(() {});
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 8.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    imageUrl: movie.fullPosterUrl,
                    width: 80,
                    height: 120,
                    fit: BoxFit.cover,
                    placeholder: (context, url) {
                      return SizedBox(
                        width: 80,
                        height: 120,
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.black,
                          ),
                        ),
                      );
                    },
                    errorWidget: (context, url, error) => SizedBox(
                      width: 80,
                      height: 120,
                      child: Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          size: 80,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${movie.title}${movie.releaseDate.isNotEmpty ? ", ${movie.releaseDate.substring(0, 4)}" : ""}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          getRatingIcon(movie.rating),
                          const SizedBox(width: 4),
                          Text(
                            "${movie.rating.toStringAsFixed(1)} / 10",
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          WatchLaterButton(
                            movie: movie,
                            color: Colors.black,
                            size: 35.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

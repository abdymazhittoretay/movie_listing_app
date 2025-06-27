import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_listing_app/models/movie_model.dart';
import 'package:movie_listing_app/utils/rating_utils.dart';

class MovieDetailPage extends StatelessWidget {
  final MovieModel movie;

  const MovieDetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double appBarHeight = kToolbarHeight;

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
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: screenHeight - appBarHeight),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: CachedNetworkImage(
                      imageUrl: movie.fullPosterUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const SizedBox(
                        width: 150,
                        height: 220,
                        child: Center(
                          child: CircularProgressIndicator(color: Colors.black),
                        ),
                      ),
                      errorWidget: (context, url, error) => const SizedBox(
                        width: 150,
                        height: 220,
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          size: 80,
                        ),
                      ),
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
                  const Divider(
                    height: 32.0,
                    thickness: 1.3,
                    color: Colors.black,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Description:",
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    movie.overview.isNotEmpty
                        ? movie.overview
                        : "No description.",
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 18.0),
                  ),

                  const Spacer(),

                  const SizedBox(height: 16.0),
                  Text(
                    "Thanks to The Movie Database (TMDb) for the data.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

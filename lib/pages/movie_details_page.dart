import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movie_listing_app/models/movie_model.dart';
import 'package:movie_listing_app/utils/rating_utils.dart';

class MovieDetailPage extends StatefulWidget {
  final MovieModel movie;

  const MovieDetailPage({super.key, required this.movie});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late Box<MovieModel> _favoritesBox;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _favoritesBox = Hive.box<MovieModel>('favoritesBox');
    _isFavorite = _favoritesBox.containsKey(widget.movie.id);
  }

  void _toggleFavorite() {
    setState(() {
      if (_isFavorite) {
        _favoritesBox.delete(widget.movie.id);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              backgroundColor: Colors.black87,
              content: Center(
                child: Text("Removed from Watch Later", style: TextStyle()),
              ),
              duration: Duration(seconds: 1),
            ),
          );
      } else {
        _favoritesBox.put(widget.movie.id, widget.movie);
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
      _isFavorite = !_isFavorite;
    });
  }

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
            Flexible(
              child: Text(widget.movie.title, overflow: TextOverflow.ellipsis),
            ),
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
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        CachedNetworkImage(
                          imageUrl: widget.movie.fullPosterUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const SizedBox(
                            width: 150,
                            height: 220,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
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
                        Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                            onPressed: _toggleFavorite,
                            icon: Icon(
                              _isFavorite
                                  ? Icons.bookmark
                                  : Icons.bookmark_add_outlined,
                              color: Colors.white,
                              size: 40.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    "${widget.movie.title}${widget.movie.releaseDate.isNotEmpty ? ", ${widget.movie.releaseDate.substring(0, 4)}" : ""}",
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
                      getRatingIcon(widget.movie.rating),
                      const SizedBox(width: 8),
                      Text(
                        '${widget.movie.rating.toStringAsFixed(1)} / 10 - TMDb',
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
                    widget.movie.overview.isNotEmpty
                        ? widget.movie.overview
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

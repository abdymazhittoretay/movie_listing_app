import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movie_listing_app/models/movie_model.dart';
import 'package:movie_listing_app/services/api_service.dart';
import 'package:movie_listing_app/widgets/bookmark_button_actions.dart';
import 'package:movie_listing_app/widgets/my_listview_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  Future<List<MovieModel>>? _searchResults;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  void _performSearch(String query) {
    if (query.trim().isEmpty) {
      setState(() {
        _searchResults = null;
      });
      return;
    }
    setState(() {
      _searchResults = apiService.value.searchMovies(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search),
            SizedBox(width: 8.0),
            Text("Search Movies"),
          ],
        ),
        centerTitle: true,
        actions: [BookmarkButtonActions()],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _controller,
              onSubmitted: _performSearch,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _controller.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _controller.clear();
                          setState(() {
                            _searchResults = null;
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: _searchResults == null
                ? Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextButton.icon(
                          onPressed: () {
                            final box = Hive.box<MovieModel>(
                              'searchHistoryBox',
                            );
                            box.clear();
                          },
                          icon: const Icon(Icons.delete_outline),
                          label: const Text(
                            "Clear History",
                            style: TextStyle(fontSize: 16.0),
                          ),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(8.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            foregroundColor: Colors.redAccent.withRed(255),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ValueListenableBuilder(
                          valueListenable: Hive.box<MovieModel>(
                            'searchHistoryBox',
                          ).listenable(),
                          builder: (context, Box<MovieModel> box, _) {
                            final movies = box.values
                                .toList()
                                .reversed
                                .toList();
                            if (movies.isEmpty) {
                              return const Center(
                                child: Text('Search for something...'),
                              );
                            }
                            return MyListviewWidget(movies: movies);
                          },
                        ),
                      ),
                    ],
                  )
                : FutureBuilder<List<MovieModel>>(
                    future: _searchResults,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      }
                      final movies = snapshot.data ?? [];
                      if (movies.isEmpty) {
                        return const Center(child: Text('No results found.'));
                      }
                      return MyListviewWidget(
                        movies: movies,
                        onMovieTap: (MovieModel movie) {
                          final box = Hive.box<MovieModel>('searchHistoryBox');

                          final exists = box.values.any(
                            (m) => m.id == movie.id,
                          );
                          if (!exists) {
                            if (box.length >= 10) box.deleteAt(0);
                            box.add(movie);
                          }
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

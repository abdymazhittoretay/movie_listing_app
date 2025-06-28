import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movie_listing_app/models/movie_model.dart';
import 'package:movie_listing_app/widgets/my_listview_widget.dart';

class WatchLaterPage extends StatelessWidget {
  const WatchLaterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<MovieModel>('favoritesBox');

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.bookmark),
            const SizedBox(width: 4.0),
            const Text('Watch Later'),
          ],
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<MovieModel> box, _) {
          if (box.isEmpty) {
            return const Center(child: Text("No saved movies yet."));
          }

          final movies = box.values.toList();

          return MyListviewWidget(movies: movies);
        },
      ),
    );
  }
}

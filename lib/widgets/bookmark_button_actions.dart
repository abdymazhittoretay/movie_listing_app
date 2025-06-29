import 'package:flutter/material.dart';
import 'package:movie_listing_app/pages/watch_later_page.dart';

class BookmarkButtonActions extends StatelessWidget {
  const BookmarkButtonActions({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WatchLaterPage()),
        );
      },
      icon: Icon(Icons.bookmark),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movie_listing_app/pages/watch_later_page.dart';

class BookmarkButtonActions extends StatelessWidget {
  const BookmarkButtonActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4.0),
      child: IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WatchLaterPage()),
          );
        },
        icon: Icon(Icons.bookmark, size: 30.0),
      ),
    );
  }
}

import 'package:flutter/material.dart';

Icon getRatingIcon(double rating) {
  if (rating >= 8.0) {
    return const Icon(Icons.star, color: Colors.green);
  } else if (rating >= 5.0) {
    return const Icon(Icons.star_half, color: Colors.amber);
  } else {
    return const Icon(Icons.star_border, color: Colors.red);
  }
}
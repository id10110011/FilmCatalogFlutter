import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/movie.dart';

class MovieConverter {
  static Movie movieFromSnapshot(DocumentSnapshot<Object?> snapshot) {
    return Movie(
      snapshot["name"] ?? "",
      snapshot["description"] ?? "",
      List<String>.from(snapshot["pictureNames"] ?? [])
    );
  }

  static Map<String, dynamic> movieToJSON(Movie movie) {
    return {
      "name": movie.name,
      "description": movie.description,
      "pictureNames": movie.pictures
    };
  }
}
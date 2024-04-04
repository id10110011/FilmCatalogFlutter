import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:film_catalog_flutter/utils/movie_converter.dart';

import '../models/movie.dart';

class MovieService {
  final CollectionReference _moviesCollection =
      FirebaseFirestore.instance.collection("movies");

  Future<DocumentSnapshot<Object?>> getMovie(String docName) async {
    return await _moviesCollection.doc(docName).get();
  }

  Future<List<DocumentReference>> getMovieReferences() async {
    QuerySnapshot result = await _moviesCollection.get();
    return List<DocumentReference>.from(result.docs.map((e) => e.reference));
  }

  Future<List<Movie>> getMovies() async {
    QuerySnapshot result = await _moviesCollection.get();
    List<Movie> movies = result.docs.map((e) => MovieConverter.movieFromSnapshot(e)).cast<Movie>().toList();
    return movies;
  }
}
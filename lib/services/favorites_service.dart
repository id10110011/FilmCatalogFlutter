import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:film_catalog_flutter/utils/movie_converter.dart';

import '../models/movie.dart';

class FavoritesService {
  final CollectionReference _favoritesCollection =
  FirebaseFirestore.instance.collection("favorites");

  Future<Movie?> getMovie(String docName) async {
    DocumentSnapshot<Object?> result = await _favoritesCollection.doc(docName).get();
    return MovieConverter.movieFromSnapshot(result);
  }

  Future<List<DocumentReference>> getFavoritesMovieReferences(String? email) async {
    DocumentSnapshot result = await _favoritesCollection.doc(email).get();
    return List<DocumentReference>.from(result["refArray"] ?? []);
  }

  Future<List<Movie>> getFavoritesMovies(List<DocumentReference> docs) async {
    List<Movie> movies = List.empty(growable: true);
    for (DocumentReference doc in docs) {
      DocumentSnapshot<Object?> snapshot = await doc.get();
      movies.add(MovieConverter.movieFromSnapshot(snapshot));
    }
    return movies;
  }

  Future<void> createFavoritesMovies(String? email) async {
    return await _favoritesCollection.doc(email).set({"refArray": List<DocumentReference>.empty(growable: true)});
  }

  Future<void> saveFavoritesMovies(List<DocumentReference> docs, String? email) async {
    return await _favoritesCollection.doc(email).set({"refArray": docs});
  }

  Future<bool> deleteFavoriteDoc(String? email) async {
    return _favoritesCollection.doc(email).delete()
        .then((value) => true);
  }
}
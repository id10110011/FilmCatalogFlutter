import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:film_catalog_flutter/services/favorites_service.dart';
import 'package:film_catalog_flutter/ui/widgets/card_widget.dart';
import 'package:flutter/material.dart';

import '../../../models/movie.dart';
import '../../../services/auth_service.dart';
import '../movie/movie_details_page.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final FavoritesService _favoritesService = FavoritesService();
  final FirebaseAuthService _auth = FirebaseAuthService();

  final List<Movie> _movies = List.empty(growable: true);

  Future<void> _fetchMovies() async {
    List<DocumentReference> docs = await _favoritesService.getFavoritesMovieReferences(_auth.getCurrentUser()?.email);
    List<Movie> movies = await _favoritesService.getFavoritesMovies(docs);
    for (int i = 0; i < movies.length; i++) {
      movies[i].docName = docs[i].id;
    }
    setState(() {
      _movies.clear();
      _movies.addAll(movies);
    });
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _fetchMovies();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(
                  top: 15
              ),
              color: Colors.white10,
              child: GridView.count(
                physics: const AlwaysScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.7,
                children: _movies.map((movie) {
                  return InkWell (
                    child: CardItem(
                      movie: movie,
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                          MovieDetailsPage(movie: movie)));
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
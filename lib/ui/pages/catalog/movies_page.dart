import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:film_catalog_flutter/services/movies_service.dart';
import 'package:film_catalog_flutter/ui/pages/movie/movie_details_page.dart';
import 'package:film_catalog_flutter/ui/widgets/card_widget.dart';
import 'package:flutter/material.dart';

import '../../../models/movie.dart';
import '../../widgets/input_container_widget.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {

  final MovieService _movieService = MovieService();

  final List<Movie> _movies = List.empty(growable: true);
  String _search = "";

  Future<void> _fetchMovies() async {
    List<DocumentReference> docs = await _movieService.getMovieReferences();
    List<Movie> movies = await _movieService.getMovies();
    for (int i = 0; i < movies.length; i++) {
      movies[i].docName = docs[i].id;
    }
    setState(() {
      _movies.clear();
      _movies.addAll(movies);
    });
  }

  List<Movie> _getFilteredMovies() {
    return _movies.where((e) {
      final name = e.name.toLowerCase();
      final filter = _search.toLowerCase();
      return name.contains(filter);
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.black,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 5
            ),
            child: FormContainerWidget(
              maxLength: 80,
              onChanged: (value) => {
                setState(() {
                  _search = value;
                })
              },
              hintText: "Search",
              isPasswordField: false,
            ),
          ),
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
                children: _getFilteredMovies().map((movie) {
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
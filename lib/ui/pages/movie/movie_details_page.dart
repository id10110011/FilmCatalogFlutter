import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:film_catalog_flutter/services/movies_service.dart';
import 'package:flutter/material.dart';

import '../../../models/movie.dart';
import '../../../services/auth_service.dart';
import '../../../services/favorites_service.dart';

class MovieDetailsPage extends StatefulWidget {
  final Movie movie;
  const MovieDetailsPage({super.key, required this.movie});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  final FavoritesService _favoritesService = FavoritesService();
  final FirebaseAuthService _auth = FirebaseAuthService();
  final MovieService _movieService = MovieService();

  List<DocumentReference> _favoritesDocs = List.empty(growable: true);

  void _backOnPressed() {
    Navigator.pop(context);
  }

  void _addToFavorites() async {
    if (_favoritesDocs.any((e) => e.id == widget.movie.docName)) {
      _favoritesDocs.removeWhere((e) => e.id == widget.movie.docName);
    } else {
      DocumentSnapshot<Object?> doc = await _movieService.getMovie(widget.movie.docName);
      _favoritesDocs.add(doc.reference);
    }
    _favoritesService.saveFavoritesMovies(_favoritesDocs, _auth.getCurrentUser()?.email);
    setState(() {

    });
  }

  Future<void> _fetchMovies() async {
    List<DocumentReference> docs = await _favoritesService.getFavoritesMovieReferences(_auth.getCurrentUser()?.email);
    setState(() {
      _favoritesDocs = docs;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              color: Colors.black,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: _backOnPressed
                  ),
                  const SizedBox(width: 17,),
                  const Text(
                    "Movie details",
                    style: TextStyle(fontSize: 20, color: Colors.white70),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(
                        _favoritesDocs.any((e) => e.id == widget.movie.docName) ? Icons.bookmark_added : Icons.bookmark,
                        color: Colors.white
                    ),
                    onPressed: _addToFavorites,
                  )
                ],
              ),
            ),
          Expanded(
              child: SingleChildScrollView (
                child: Column(
                  children: [
                    CachedNetworkImage(
                      fit: BoxFit.fitWidth,
                      imageUrl: widget.movie.pictures.isNotEmpty ? widget.movie.pictures[0] : "",
                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                          CircularProgressIndicator(value: downloadProgress.progress),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                    const SizedBox(height: 20,),
                    Text(
                      widget.movie.name,
                      style: const TextStyle(fontSize: 25, color: Colors.black,),
                    ),
                    const SizedBox(height: 20,),
                    const Text(
                      "Description",
                      style: TextStyle(fontSize: 20, color: Colors.black,),
                    ),
                    const SizedBox(height: 20,),
                    Text(
                      widget.movie.description,
                      style: const TextStyle(fontSize: 17, color: Colors.black,),
                    ),
                    const SizedBox(height: 20,),
                    widget.movie.pictures.length > 1 ? const Text(
                      "Pictures",
                      style: TextStyle(fontSize: 20, color: Colors.black,),
                    ) : const SizedBox(height: 0,),
                    const SizedBox(height: 15,),
                    widget.movie.pictures.length > 1 ? CarouselSlider(
                      items: widget.movie.pictures.sublist(1).map((e) {
                        return CachedNetworkImage(
                          fit: BoxFit.fitWidth,
                          imageUrl: e,
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              CircularProgressIndicator(value: downloadProgress.progress),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                      );
                      }).toList(),
                      options: CarouselOptions(
                        // Customize the height of the carousel
                        autoPlay: true, // Enable auto-play
                        enlargeCenterPage: true, // Increase the size of the center item
                        enableInfiniteScroll: true, // Enable infinite scroll
                        onPageChanged: (index, reason) {
                          // Optional callback when the page changes
                          // You can use it to update any additional UI components
                        },
                      ),
                    ) : const SizedBox(height: 0,),
                  ],
                )
              )
            )
          ]
        )
      )
    );
  }
}
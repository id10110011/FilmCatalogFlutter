import 'package:film_catalog_flutter/services/auth_service.dart';
import 'package:film_catalog_flutter/ui/pages/favorites/favorites_page.dart';
import 'package:film_catalog_flutter/ui/pages/auth/login_page.dart';
import 'package:film_catalog_flutter/ui/pages/catalog/movies_page.dart';
import 'package:film_catalog_flutter/ui/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final FirebaseAuthService _authService = FirebaseAuthService();
  final List<Widget> _body = const [
    MoviesPage(),
    FavoritesPage(),
    ProfilePage(),
  ];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
      return SafeArea(
          child: _authService.getCurrentUser() == null
          ? const LoginPage()
          : Scaffold(
            body: Container(
              child: _body[_currentIndex],
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.black,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey,
              currentIndex: _currentIndex,
              onTap: (int newIndex) {
                setState(() {
                  _currentIndex = newIndex;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  backgroundColor: Colors.white,
                  label: "Movies",
                  icon: Icon(Icons.movie_outlined),
                ),
                BottomNavigationBarItem(
                  backgroundColor: Colors.white,
                  label: "Favorites",
                  icon: Icon(Icons.bookmarks_outlined),
                ),
                BottomNavigationBarItem(
                  backgroundColor: Colors.white,
                  label: "Profile",
                  icon: Icon(Icons.person),
                )
              ],
            ),
          )
      );
  }
}

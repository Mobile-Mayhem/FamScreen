import 'package:flutter/material.dart';
import 'package:famscreen/services/fav_movies_services.dart';

import '../widgets/FavItem.dart';
import 'DetailPage.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<Map<String, dynamic>> favoriteMovies = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    List<Map<String, dynamic>> movies =
        await FavMoviesServices().getFavMovies();
    setState(() {
      favoriteMovies = movies;
    });
  }

  Future<void> _removeFavorite(String title) async {
    await FavMoviesServices().removeFav(title);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$title dihapus dari favorit.')),
    );
    _loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Favorit',
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: favoriteMovies.isEmpty
          ? Center(
              child: Text('Belum ada film favorit.'),
            )
          : GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.6,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: favoriteMovies.length,
              itemBuilder: (context, index) {
                var movie = favoriteMovies[index];
                return FavoriteItem(
                  title: movie['judul'],
                  image: movie['poster_potrait'] ?? 'assets/placeholder.jpg',
                  onRemove: () => _removeFavorite(movie['judul']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(movie: movie),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

import 'package:famscreen/services/user_services.dart';
import 'package:famscreen/widgets/SearchBar.dart';
import 'package:flutter/material.dart';
import 'package:famscreen/services/fav_movies_services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/FavItem.dart';
import 'DetailPage.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<Map<String, dynamic>> favoriteMovies = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    List<Map<String, dynamic>> movies =
        await FavMoviesServices().getFavMovies();
    if (mounted) {
      setState(() {
        favoriteMovies = movies;
        isLoading = false;
      });
    }
  }

  Future<void> _removeFavorite(String title) async {
    await UserServices().removeFav(title);
    Fluttertoast.showToast(
      msg: '$title Dihapus Dari Favorit',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
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
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SearchInput(
              onChanged: (query) {
                setState(() {
                  favoriteMovies = favoriteMovies
                      .where((movie) => movie['judul']
                          .toString()
                          .toLowerCase()
                          .contains(query.toLowerCase()))
                      .toList();
                });
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : favoriteMovies.isEmpty
                      ? Center(
                          child: Text('Belum ada film favorit.'),
                        )
                      : GridView.builder(
                          padding: EdgeInsets.all(3),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.6,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 5,
                          ),
                          itemCount: favoriteMovies.length,
                          itemBuilder: (context, index) {
                            var movie = favoriteMovies[index];
                            return FavoriteItem(
                              title: movie['judul'],
                              image: movie['poster_potrait'] ??
                                  'assets/placeholder.jpg',
                              onRemove: () => _removeFavorite(movie['judul']),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailPage(movie: movie),
                                  ),
                                );
                              },
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

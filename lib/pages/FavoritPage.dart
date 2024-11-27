import 'package:flutter/material.dart';
import 'package:famscreen/services/fav_movies_services.dart';

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
                  image: movie['poster_landscap'] ?? 'assets/placeholder.jpg',
                );
              },
            ),
    );
  }
}

class FavoriteItem extends StatelessWidget {
  final String title;
  final String image;

  const FavoriteItem({required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 120,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: GestureDetector(
                onTap: () async {
                  await FavMoviesServices().removeFav(title);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$title dihapus dari favorit.')),
                  );
                },
                child: Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(fontSize: 12),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

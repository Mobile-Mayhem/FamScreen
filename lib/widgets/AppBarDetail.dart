import 'package:famscreen/pages/HomePage.dart';
import 'package:famscreen/pages/ListMoviesPage.dart';
import 'package:flutter/material.dart';

class AppBarDetail extends StatelessWidget {
  final Future<bool> isFavoriteFuture;
  final Function toggleFavorite;

  const AppBarDetail({
    Key? key,
    required this.isFavoriteFuture,
    required this.toggleFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
      ),
      actions: [
        FutureBuilder<bool>(
          future: isFavoriteFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            bool isFavorite = snapshot.data ?? false;

            return Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.white,
                ),
                onPressed: () => toggleFavorite(),
              ),
            );
          },
        ),
      ],
    );
  }
}

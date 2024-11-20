import 'package:famscreen/components/filter_jenis.dart';
import 'package:famscreen/data/models/film.dart';
import 'package:famscreen/components/navbar.dart';
import 'package:famscreen/data/provider/favorite_provider.dart';
import 'package:famscreen/pages/DetailPage.dart';
import 'package:famscreen/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritPage extends StatelessWidget {
  //final Film film;

  const FavoritPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Favorit',
          style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            (route) => route.isFirst,
          );
        },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<FavoriteFilmsProvider>( // Menggunakan Consumer untuk mendengarkan perubahan
          builder: (context, favoriteFilmsProvider, child) {
            List<Film> favoriteFilms = favoriteFilmsProvider.favoriteFilms; // Ambil daftar favorit
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari favorit',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CategoryRow(
                  allFilms: favoriteFilms, 
                  selectedCategory: 'All',
                  onCategorySelected: (String category) {},
                  onFilteredFilms: (List<Film> filteredFilms) {},
                ),
                SizedBox(height: 16),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.6,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: favoriteFilms.length, 
                    itemBuilder: (context, index) {
                      Film film = favoriteFilms[index]; 
                      return FavoriteItem(
                        film: film,
                        title: film.judul,
                        image: film.poster,
                        isFavorite: true,
                        onFavoriteChanged: () {
                          favoriteFilmsProvider.toggleFavorite(film);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: 1,
        onDestinationSelected: (int index) {},
      ),
    );
  }
}

class FavoriteItem extends StatelessWidget {
  final Film film;
  final String title;
  final String image;
  final bool isFavorite;
  final VoidCallback onFavoriteChanged;

  const FavoriteItem({
    required this.film,
    required this.title,
    required this.image,
    required this.isFavorite,
    required this.onFavoriteChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(film: film),
          ),
        );
      },
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 130,
                width: 110,
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
                child: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.white,
                    size: 20,
                  ),
                  onPressed: onFavoriteChanged, // Panggil toggleFavorite saat ikon diklik
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
      ),
    );
  }
}

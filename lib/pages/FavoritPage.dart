import 'package:famscreen/components/filter_jenis.dart';
import 'package:famscreen/data/models/film.dart';
import 'package:famscreen/pages/HomePage.dart';
import 'package:flutter/material.dart';
import '../components/navbar.dart';

class FavoritPage extends StatefulWidget {
  const FavoritPage({Key? key}) : super(key: key);

  @override
  State<FavoritPage> createState() => _FavoritPageState();
}

class _FavoritPageState extends State<FavoritPage> {
  int currentPageIndex = 1;

  List<Film>? films; 
  List<Film> favoriteFilms = []; // List untuk menyimpan film favorit
  String selectedCategory = 'All';
  List<Film>? displayedFilms;
  bool isLoaded = false;

  void updateCategory(List<Film> filteredFilms) {
    setState(() {
      displayedFilms = filteredFilms;
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
        child: Column(
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
            // filter jenis
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CategoryRow(
                  allFilms: films ?? [], 
                  selectedCategory: selectedCategory,
                  onCategorySelected: (String category) {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                  onFilteredFilms: updateCategory,
                ),
              ],
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
                    title: film.judul,
                    image: film.poster,
                    isFavorite: true,
                    onFavoriteChanged: () {
                      setState(() {
                        if (favoriteFilms.contains(film)) {
                          favoriteFilms.remove(film);
                        } else {
                          favoriteFilms.add(film);
                        }
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
    );
  }
}

class FavoriteItem extends StatelessWidget {
  final String title;
  final String image;
  final bool isFavorite; // Menandakan apakah film ini favorit
  final VoidCallback onFavoriteChanged; // Callback ketika status favorit berubah

  const FavoriteItem({
    required this.title,
    required this.image,
    required this.isFavorite,
    required this.onFavoriteChanged,
  });

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
              child: IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: isFavorite ? Colors.red : Colors.grey, // Mengubah warna ikon berdasarkan status favorit
                  size: 20,
                ),
                onPressed: onFavoriteChanged, // Panggil callback untuk mengubah status favorit
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

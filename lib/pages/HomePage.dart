import 'package:flutter/material.dart';
import '../components/filter_jenis.dart';
import '../data/models/film.dart';
import '../data/service/film_service.dart';
import 'DetailPage.dart';
// import 'FavoritePage.dart';
import '../components/navbar.dart'; //coba navbar

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

  List<Film>? films;
  List<Film>? displayedFilms;
  bool isLoaded = false;
  String selectedCategory = 'All';

  void updateCategory(List<Film> filteredFilms) {
    setState(() {
      displayedFilms = filteredFilms;
    });
  }

  @override
  void initState() {
    super.initState();
    loadFilms();
  }

  Future<void> loadFilms() async {
    final filmService = FilmService();
    films = await filmService.getFilms();
    setState(() {
      isLoaded = true;
      displayedFilms = films;
    });
  }

  Widget _buildMovieCard(Film film) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                DetailPage(film: film),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              film.poster,
              height: 250,
              width: 180,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  film.judul,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.star, color: Colors.yellow[800], size: 16),
              const SizedBox(width: 4),
              Text(film.rateImdb.toString()),
            ],
          ),
          Text(
            film.durasi.toString(),
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'FamScreen',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              const SizedBox(height: 16),

              const Text(
                'Rekomendasi',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Grid film
              isLoaded && displayedFilms != null
                  ? GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.53,
                        mainAxisSpacing: 0.5,
                        crossAxisSpacing: 18,
                      ),
                      itemCount: displayedFilms!.length,
                      itemBuilder: (context, index) {
                        return _buildMovieCard(displayedFilms![index]);
                      },
                    )
                  : const Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),

      // Navbar
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

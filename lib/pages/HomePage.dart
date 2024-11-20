import 'package:famscreen/utils/Colors.dart';
import 'package:flutter/material.dart';
import '../components/filter_jenis.dart';
import '../data/models/film.dart';
import '../data/service/film_service.dart';
import '../services/movie_service.dart';
import 'DetailPage.dart';
// import 'FavoritePage.dart';
import '../components/navbar.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
  final MovieService movieService = MovieService();

  // Future<void> loadFilms() async {
  //   films = await movieService.loadFilms();
  //   setState(() {
  //     isLoaded = true;
  //     displayedFilms = films;
  //   });
  // }

  void updateCategory(List<Film> filteredFilms) {
    setState(() {
      displayedFilms = filteredFilms;
    });
  }

  @override
  void initState() {
    super.initState();
    // loadFilms();
  }

  // Future<void> loadFilms() async {
  //   final filmService = FilmService();
  //   films = await filmService.getFilms();
  //   setState(() {
  //     isLoaded = true;
  //     displayedFilms = films;
  //   });
  // }

  Widget _buildSkeletonCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: 220,
            width: 180,
            color: Colors.grey[300],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 16,
          width: 180,
          color: Colors.grey[300],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              height: 16,
              width: 50,
              color: Colors.grey[300],
            ),
            const SizedBox(width: 55),
            Container(
              height: 16,
              width: 50,
              color: Colors.grey[300],
            ),
          ],
        ),
      ],
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
      body: RefreshIndicator(
        onRefresh: MovieService().loadFilms,
        color: CustomColor.primary,
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                Skeletonizer(
                  enabled: !isLoaded,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.53,
                      mainAxisSpacing: 0.5,
                      crossAxisSpacing: 18,
                    ),
                    itemCount: isLoaded ? displayedFilms!.length : 4,
                    itemBuilder: (context, index) {
                      if (!isLoaded) {
                        return _buildSkeletonCard();
                      }

                      return _buildMovieCard(displayedFilms![index]);
                    },
                  ),
                ),
              ],
            ),
          ),
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

import 'package:famscreen/utils/Colors.dart';
import 'package:flutter/material.dart';
import '../components/filter_jenis.dart';
import '../data/models/film.dart';
import '../data/service/film_service.dart';
import '../models/movies.dart';
import '../services/databases_services.dart';
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

  List<Movies>? movie;
  List<Movies>? displayedMovies;
  bool isLoaded = false;
  String selectedCategory = 'All';

  void updateCategory(List<Film> filteredMovies) {
    setState(() {
      displayedMovies = filteredMovies.cast<Movies>();
    });
  }

  @override
  void initState() {
    super.initState();
    loadMovies();
  }

  Future<void> loadMovies() async {
    final databaseService = DatabasesServices(); // Initialize DatabasesServices
    try {
      databaseService.getMoviesStream().listen((querySnapshot) {
        // Map Firestore documents to Movies objects
        movie = querySnapshot.docs.map((doc) => doc.data() as Movies).toList();

        setState(() {
          isLoaded = true;
          displayedMovies = movie; // Set the movie to be displayed
        });
      });
    } catch (e) {
      setState(() {
        isLoaded = true; // Set loading to true so UI doesn't hang
      });
      print('Error fetching movies: $e');
    }
  }

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
    );
  }

  Widget _buildMovieCard(Movies movie) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (_) =>
        //         DetailPage(movie: movie), // Passing Movies object to DetailPage
        //   ),
        // );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              movie.posterPotrait,
              height: 220,
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
                  movie.judul,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    '${movie.durasi}m',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow[800], size: 16),
                  const SizedBox(width: 4),
                  Text(movie.rateImdb.toString()),
                ],
              ),
            ],
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
      body: RefreshIndicator(
        onRefresh: loadMovies,
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
                      allFilms: movie?.cast<Film>() ?? [],
                      selectedCategory: selectedCategory,
                      onCategorySelected: (String category) {
                        setState(() {
                          selectedCategory = category;
                        });

                        // Filter the movies based on category selection
                        if (category == 'All') {
                          displayedMovies = movie;
                        } else {
                          displayedMovies = movie
                              ?.where((movie) => movie.jenis == category)
                              .toList();
                        }
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
                    itemCount: isLoaded ? displayedMovies?.length : 4,
                    itemBuilder: (context, index) {
                      if (!isLoaded) {
                        return _buildSkeletonCard();
                      }

                      return _buildMovieCard(displayedMovies![index]);
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

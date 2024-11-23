import 'package:famscreen/models/movies.dart';
import 'package:famscreen/utils/Colors.dart';
import 'package:famscreen/widgets/MovieCard.dart';
import 'package:flutter/material.dart';
import '../components/filter_jenis.dart';
import '../data/models/film.dart';
import '../services/databases_services.dart';
import '../components/navbar.dart';

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
        final fetchedMovies =
            querySnapshot.docs.map((doc) => doc.data() as Movies).toList();

        setState(() {
          isLoaded = true;
          movie = fetchedMovies; // Set the fetched movies
          displayedMovies = fetchedMovies; // Set the movies to be displayed
        });
      });
    } catch (e) {
      setState(() {
        isLoaded = true; // Ensure the UI does not hang
      });
      print('Error fetching movies: $e');
    }
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
                  // children: [
                  //   FilterJenis();
                  // ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Rekomendasi',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                MovieCard(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = currentPageIndex;
          });
        },
      ),
    );
  }
}
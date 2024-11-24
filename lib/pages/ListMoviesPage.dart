import 'package:famscreen/data/dbMovies.dart';
import 'package:famscreen/utils/Colors.dart';
import 'package:famscreen/widgets/MovieCard.dart';
import 'package:flutter/material.dart';
import '../services/databases_services.dart';

class ListMoviesPage extends StatefulWidget {
  const ListMoviesPage({super.key});

  @override
  _ListMoviesPageState createState() => _ListMoviesPageState();
}

class _ListMoviesPageState extends State<ListMoviesPage> {
  final dbServices = DatabasesServices();
  final data = DBMovies().movies;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:
            false, // Adjust based on need for back button
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'FamScreen',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                const Text(
                  'Rekomendasi',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                MovieCard(), // Movie card will display the movies from the database
              ],
            ),
          ),
        ),
      ),
      // ! Hapus saat production
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await dbServices
                .addData(data[0]); // Add the first movie for debugging
            for (var movie in data) {
              await dbServices.addData(movie); // Add all movies to the database
            }
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Movies added successfully!"),
            ));
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Error adding movies: $e"),
            ));
          }
        },
        child: const Icon(Icons.add),
        backgroundColor: CustomColor.primary,
      ),
    );
  }
}

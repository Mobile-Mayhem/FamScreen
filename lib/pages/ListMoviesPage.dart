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
    );
  }
}

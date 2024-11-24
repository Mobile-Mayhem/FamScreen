import 'package:famscreen/data/dbMovies.dart';
import 'package:famscreen/utils/Colors.dart';
import 'package:famscreen/widgets/MovieCard.dart';
import 'package:flutter/material.dart';
import '../services/databases_services.dart';
import '../components/navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

  final dbServices = DatabasesServices();

  final data = DBMovies().movies;

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
      body: Container(
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
      // ! NANTI HAPUS, INI BUAT DEBUG AJA
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // dbServices.deleteAllDocuments('movies');
          await dbServices.addData(data[0]);
          for (var movie in data) {
            await dbServices.addData(movie);
          }
        },
        child: const Icon(Icons.add),
        backgroundColor: CustomColor.primary,
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

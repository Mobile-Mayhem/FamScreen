import 'package:famscreen/pages/HomePage.dart';
import 'package:famscreen/pages/DetailPage.dart';
import 'package:flutter/material.dart';
import '../components/navbar.dart';
import '../data/service/film_service.dart';
import '../data/models/film.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int currentPageIndex = 2;
  List<Film> searchResults = [];
  final FilmService filmService = FilmService();
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;

  void performSearch(String query) async {
    setState(() {
      isLoading = true;
    });

    try {
      final results = await filmService.searchFilms(query);
      setState(() {
        searchResults = results;
      });
    } catch (e) {
      print("Error searching films: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white, 
    appBar: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        'Search',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
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
        children: [
          TextField(
            controller: searchController,
            onSubmitted: (query) {
              if (query.isNotEmpty) {
                performSearch(query);
              }
            },
            decoration: InputDecoration(
              hintText: 'Cari film',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : searchResults.isEmpty
                    ? Center(child: Text('Tidak ada hasil untuk pencarian ini'))
                    : ListView.builder(
                        itemCount: searchResults.length,
                        itemBuilder: (context, index) {
                          final film = searchResults[index];
                          return ListTile(
                            title: Text(film.judul),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPage(film: film),
                                ),
                              );
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
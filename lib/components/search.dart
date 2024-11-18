import 'package:famscreen/pages/DetailPage.dart';
import 'package:flutter/material.dart';
import '/data/models/film.dart';
import '/data/service/film_service.dart';

class SearchWidget extends StatefulWidget {
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  List<Film> searchResults = [];
  List<String> searchHistory = []; 
  bool isLoading = false;
  final TextEditingController _searchController = TextEditingController();

  // Fungsi untuk menambahkan riwayat pencarian
  void _addToSearchHistory(String query) {
    if (query.isEmpty || searchHistory.contains(query)) return;
    setState(() {
      searchHistory.insert(0, query); 
      if (searchHistory.length > 10) {
        searchHistory.removeLast(); 
      }
    });
  }

  
  void _searchFilms(String judul) async {
    if (judul.isEmpty) return;

    setState(() {
      isLoading = true;
    });

    try {
      final filmService = FilmService();
      final results = await filmService.searchFilms(judul);

      setState(() {
        searchResults = results;
        _addToSearchHistory(judul);
      });
    } catch (error) {
      print("Error searching films: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to search for films.')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Search for a movie',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  FocusScope.of(context).unfocus(); 
                  _searchFilms(_searchController.text); 
                },
              ),
            ),
            onSubmitted: (judul) {
              FocusScope.of(context).unfocus(); 
              _searchFilms(judul); 
            },
          ),
          const SizedBox(height: 10),
          if (searchHistory.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Search History:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Wrap(
                  spacing: 8.0,
                  children: searchHistory.map((query) {
                    return GestureDetector(
                      onTap: () {
                        _searchController.text = query; 
                        _searchFilms(query);
                      },
                      child: Chip(label: Text(query)),
                    );
                  }).toList(),
                ),
              ],
            ),
          const SizedBox(height: 10),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : searchResults.isEmpty
                  ? const Expanded(
                      child: Center(
                        child: Text(
                          'No results found.',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
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
    );
  }
}

import 'package:famscreen/pages/DetailPage.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import '../data/models/film.dart';

class SearchWidget extends StatefulWidget {
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  List<Film> searchResults = [];
  bool isLoading = false;
  final TextEditingController _searchController = TextEditingController();

  void _searchFilms(String query) async {
    setState(() {
      isLoading = true;
    });

    // try {
    //   final filmService = FilmService();
    //   final results = await filmService.searchFilms(query);
    //   setState(() {
    //     searchResults = results;
    //   });
    // } catch (error) {
    //   print("Error searching films: $error");
    // } finally {
    //   setState(() {
    //     isLoading = false;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Search for a movie',
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  _searchFilms(_searchController.text);
                },
              ),
            ),
            onSubmitted: (query) {
              _searchFilms(query);
            },
          ),
        ),
        isLoading
            ? CircularProgressIndicator()
            : Expanded(
                child: ListView.builder(
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    final film = searchResults[index];
                    return ListTile(
                      leading: Image.network(film.poster,
                          width: 50, height: 75, fit: BoxFit.cover),
                      title: Text(film.judul),
                      subtitle: Text('${film.tahunRilis} - ${film.rateImdb}'),
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
    );
  }
}

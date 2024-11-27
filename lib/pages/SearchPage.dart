import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famscreen/services/databases_services.dart';
import 'package:famscreen/widgets/SearchBar.dart';
import 'package:famscreen/widgets/SearchResultCard.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<Map<String, dynamic>> searchResults = [];
  final DatabasesServices searchService = DatabasesServices();

  Future<void> performSearch(String query) async {
    try {
      final results = await searchService.performSearch(query);
      setState(() {
        searchResults.clear();
        searchResults.addAll(results);
      });
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Search',
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchInput(
              onChanged: (query) {
                performSearch(query);
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.53,
                ),
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final movie = searchResults[index];
                  return SearchResultCard(movie: movie);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

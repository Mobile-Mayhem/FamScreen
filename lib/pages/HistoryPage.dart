import 'package:famscreen/widgets/HistoryCard.dart';
import 'package:famscreen/widgets/SearchBar.dart';
import 'package:flutter/material.dart';

import '../services/history_services.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Map<String, dynamic>> movies = [];

  @override
  void initState() {
    super.initState();
    fetchHistory();
  }

  Future<void> fetchHistory() async {
    final historyMovies = await HistoryServices().getHistMovies();
    setState(() {
      movies = historyMovies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Riwayat',
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.black),
            onPressed: () async {
              await HistoryServices().clearHistory();
              fetchHistory();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchInput(
              onChanged: (query) {
                setState(() {
                  movies = movies
                      .where((movie) => movie['judul']
                          .toString()
                          .toLowerCase()
                          .contains(query.toLowerCase()))
                      .toList();
                });
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: HistoryCard(
                      movie: movies[index],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

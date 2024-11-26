import 'package:famscreen/widgets/FilterJenis.dart';
import 'package:famscreen/widgets/HistoryCard.dart';
import 'package:famscreen/widgets/SearchBar.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistorypageState();
}
 
class _HistorypageState extends State<HistoryPage> {
  String selectedCategory = 'All'; 
  final List<Map<String, dynamic>> movies = [ // coba
    // {
    //   'poster_potrait': 'https://i.pinimg.com/736x/d2/22/ab/d222ab7828905795cd8591afe0b35721.jpg', 
    //   'judul': 'Film A',
    //   'tahun_rilis': 2023,
    //   'durasi': 120,
    //   'rate_imdb': 8.5,
    //   'deskripsi': 'Deskripsi film A yang menarik.',
    // },
  ];

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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchInput(
              onChanged: (query) {
                // 
              },
            ),
            const SizedBox(height: 20),
            FilterRow(
              selectedCategory: selectedCategory, 
              onCategorySelected: (newCategory) {
                setState(() {
                  selectedCategory = newCategory;
                });
                // 
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
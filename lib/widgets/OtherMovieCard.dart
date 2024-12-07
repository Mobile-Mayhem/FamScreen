import 'package:flutter/material.dart';
import 'package:famscreen/services/databases_services.dart';
import '../pages/DetailPage.dart';

class OtherMovieCard extends StatelessWidget {
  OtherMovieCard({super.key});

  final _dbService = DatabasesServices();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _dbService.read(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center();
        } else if (snapshot.hasError) {
          return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Tidak ada data film'));
        } else {
          final movies = snapshot.data!;

          return Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(
                movies.length > 3 ? 3 : movies.length, // Menampilkan hingga 3 film
                (index) {
                  final movie = movies[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(movie: movie),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 13.0), // Memberikan jarak antar film
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              movie['poster_potrait'],
                              height: 130,
                              width: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }
}

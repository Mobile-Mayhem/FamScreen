import 'package:cached_network_image/cached_network_image.dart';
import 'package:famscreen/utils/Colors.dart';
import 'package:famscreen/widgets/ImageSkeletonCard.dart';
import 'package:famscreen/widgets/SkeletonCard.dart';
import 'package:flutter/material.dart';
import 'package:famscreen/services/databases_services.dart';
import '../pages/DetailPage.dart';

class MovieCard extends StatelessWidget {
  final String selectedGenre;
  MovieCard({super.key, required this.selectedGenre});

  final _dbService = DatabasesServices();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _dbService.filterByGenre(selectedGenre),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: SkeletonCard());
        } else if (snapshot.hasError) {
          return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Tidak ada data film'));
        } else {
          final movies = snapshot.data!;

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              childAspectRatio: 0.53,
            ),
            itemCount: movies.length,
            itemBuilder: (context, index) {
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                              height: 220,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              imageUrl: movie['poster_potrait'],
                              placeholder: (context, url) => MoviePoster(
                                  imageUrl: movie['poster_potrait']),
                              errorWidget: (context, url, error) => Image.asset(
                                    'assets/imgnotfound.png',
                                    width: 70,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  )),
                        ),
                        Positioned(
                          top: 5,
                          left: 5,
                          child: Container(
                            decoration: BoxDecoration(
                              color: CustomColor.primary,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: const EdgeInsets.all(6),
                            child: Text(
                              movie['kategori_usia'] ?? 'N/A',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      movie['judul'] == null || movie['judul'].isEmpty
                          ? 'Judul tidak ditemukan'
                          : movie['judul'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${movie['durasi']}m',
                          style: const TextStyle(color: Colors.grey),
                        ),
                        Row(
                          children: [
                            Icon(Icons.star,
                                color: Colors.yellow[800], size: 16),
                            const SizedBox(width: 4),
                            Text(movie['rate_imdb'].toString()),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}

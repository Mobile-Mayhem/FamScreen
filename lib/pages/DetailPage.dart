import 'package:famscreen/services/fav_movies_services.dart';
import 'package:flutter/material.dart';

import '../components/MovieGenre.dart';

class DetailPage extends StatelessWidget {
  final Map<String, dynamic> movie;
  const DetailPage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.network(movie['poster_landscap'],
              width: double.infinity, height: 300, fit: BoxFit.cover),
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(top: 210),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(15)),
                    child: IconButton(
                      icon:
                          const Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  actions: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.favorite_border,
                            color: Colors.black),
                        onPressed: () {
                          // Add your favorite movie here
                          FavMoviesServices().addFav(movie);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 230, left: 25, right: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(movie['tahun_rilis'].toString(),
                        style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: const Color(0xffF5C518),
                      ),
                      child: const Text('IMDb',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 8),
                    Text(movie['rate_imdb'].toString() + ' |',
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(width: 8),
                    Text(movie['durasi'].toString() + ' menit',
                        style: TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  movie['judul'],
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                Text(
                  movie['deskripsi'],
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 15),
                MovieGenre(movie: movie),
                const SizedBox(height: 30),
                const Text(
                  'Lihat Sekarang',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/images/netflix.png',
                          width: 50,
                          height: 50,
                        ))
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  'Rekomendasi Lainnya',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

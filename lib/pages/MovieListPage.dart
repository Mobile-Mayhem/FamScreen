import 'package:flutter/material.dart';
import 'package:famscreen/services/databases_services.dart';

class Movielistpage extends StatelessWidget {
  Movielistpage({super.key});

  final _dbService = DatabasesServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Film'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _dbService.read(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada data film'));
          } else {
            final movies = snapshot.data!;
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return ListTile(
                  leading: Image.network(
                    movie['poster_potrait'],
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(movie['judul']),
                  subtitle: Text(
                      'Genre: ${movie['genre']}\nTahun: ${movie['tahun_rilis']}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailPage(movie: movie),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class MovieDetailPage extends StatelessWidget {
  final Map<String, dynamic> movie;

  const MovieDetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie['judul']),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(movie['poster_landscap']),
            const SizedBox(height: 16),
            Text(
              movie['judul'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Genre: ${movie['genre']}'),
            Text('Tahun Rilis: ${movie['tahun_rilis']}'),
            Text('Durasi: ${movie['durasi']} menit'),
            const SizedBox(height: 16),
            Text(movie['deskripsi']),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // _launchURL(movie['link_streaming']);
              },
              child: const Text('Tonton di Netflix'),
            ),
          ],
        ),
      ),
    );
  }

  // void _launchURL(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Tidak dapat membuka URL: $url';
  //   }
  // }
}

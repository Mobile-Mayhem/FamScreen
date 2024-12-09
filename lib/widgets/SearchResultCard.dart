import 'package:flutter/material.dart';
import '../pages/DetailPage.dart';

class SearchResultCard extends StatelessWidget {
  final Map<String, dynamic> movie;

  const SearchResultCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              movie['poster_potrait'],
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Image.asset(
                    'assets/imgnotfound.png',
                    height: 220,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Text(
            movie['judul'] ?? '',
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
                  Icon(Icons.star, color: Colors.yellow[800], size: 16),
                  const SizedBox(width: 4),
                  Text(movie['rate_imdb'].toString()),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

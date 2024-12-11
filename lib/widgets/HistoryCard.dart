import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../pages/DetailPage.dart';

class HistoryCard extends StatelessWidget {
  final Map<String, dynamic> movie;

  const HistoryCard({Key? key, required this.movie}) : super(key: key);

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
        children: [
          Card(
            color: Colors.white,
            elevation: 0,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                        imageUrl: movie['poster_potrait'],
                        width: 70,
                        height: 100,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Image.asset(
                              'assets/imgnotfound.png',
                              width: 70,
                              height: 100,
                              fit: BoxFit.cover,
                            )),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie['judul'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              '${movie['tahun_rilis']}  ·  ${movie['durasi']}m  ·  ',
                              style: const TextStyle(fontSize: 12),
                            ),
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 16,
                            ),
                            Text(
                              movie['rate_imdb'].toString(),
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          movie['deskripsi'],
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.grey.shade300,
            thickness: 1,
            indent: 7,
            endIndent: 7,
          ),
        ],
      ),
    );
  }
}

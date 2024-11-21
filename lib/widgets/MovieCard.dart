import 'package:famscreen/pages/DetailPage.dart';
import 'package:flutter/material.dart';

import '../data/models/film.dart';

class Moviecard extends StatefulWidget {
  final Film film;
  const Moviecard({super.key, required this.film});

  @override
  State<Moviecard> createState() => _Moviecard();
}

class _Moviecard extends State<Moviecard> {
  late final Film film;

  @override
  void initState() {
    super.initState();
    film = widget.film;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailPage(film: film),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              film.posterLandscap,
              height: 220,
              width: 180,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  film.judul,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    '${film.durasi}m',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow[800], size: 16),
                  const SizedBox(width: 4),
                  Text(film.rateImdb.toString()),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

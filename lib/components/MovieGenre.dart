import 'package:flutter/material.dart';

class MovieGenre extends StatelessWidget {
  const MovieGenre({
    super.key,
    required this.movie,
  });

  final Map<String, dynamic> movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: List<Widget>.generate(
            movie['genre'].length,
            (int index) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 228, 227, 227),
                ),
                child: Text(movie['genre'][index]),
              );
            },
          ),
        ),
      ],
    );
  }
}

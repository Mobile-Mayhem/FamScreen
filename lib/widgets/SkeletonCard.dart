import 'package:famscreen/models/movies.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletonCard extends StatelessWidget {
  final bool isLoaded;
  final int itemCount;
  final List<Movies>? displayedMovies;

  const SkeletonCard({
    super.key,
    this.isLoaded = false,
    this.itemCount = 4,
    this.displayedMovies,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: !isLoaded,
      child: GridView.builder(
        shrinkWrap: true, 
        physics: const NeverScrollableScrollPhysics(), 
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          childAspectRatio: 0.53,
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: 220,
                  width: 180,
                  color: Colors.grey[300],
                ),
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: 16,
                  width: 180,
                  color: Colors.grey[300],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Container(
                    height: 16,
                    width: 50,
                    color: Colors.grey[300],
                  ),
                ),
                const SizedBox(width: 55),
                ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Container(
                      height: 16,
                      width: 50,
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
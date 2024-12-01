import 'package:famscreen/widgets/MovieCard.dart';
import 'package:flutter/material.dart';
import '../services/databases_services.dart';

class ListMoviesPage extends StatefulWidget {
  const ListMoviesPage({super.key});

  @override
  _ListMoviesPageState createState() => _ListMoviesPageState();
}

class _ListMoviesPageState extends State<ListMoviesPage> {
  final dbServices = DatabasesServices();
  // String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'FamScreen',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
              minHeight: 60.0,
              maxHeight: 60.0,
              child: Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Rekomendasi',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          // FilterRow(
          //   selectedCategory: selectedCategory,
          //   onCategorySelected: (newCategory) {
          //     setState(() {
          //       selectedCategory = newCategory;
          //     });
          //     //
          //   },
          // ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: MovieCard(),
                );
              },
              childCount: 1, // Adjust based on the number of movie cards
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

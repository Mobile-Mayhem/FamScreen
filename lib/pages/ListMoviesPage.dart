import 'package:famscreen/widgets/FilterBottomSheet.dart';
import 'package:famscreen/widgets/MovieCard.dart';
import 'package:flutter/material.dart';
import '../services/databases_services.dart';
import '../utils/Colors.dart';
import 'CameraPage.dart';

class ListMoviesPage extends StatefulWidget {
  const ListMoviesPage({super.key});

  @override
  _ListMoviesPageState createState() => _ListMoviesPageState();
}

class _ListMoviesPageState extends State<ListMoviesPage> {
  final dbServices = DatabasesServices();
  String selectedGenre = 'semua';

   void onGenreSelected(String genre) {
    setState(() {
      selectedGenre = genre; 
    });
  }

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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Rekomendasi',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                      decoration: BoxDecoration(
                        color: CustomColor.primary, 
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet<void>(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            ),
                            builder: (BuildContext context) {
                              return FilterBottomSheet(
                                selectedGenre: selectedGenre,
                                onGenreSelected: onGenreSelected,
                              );
                            },
                          );
                        },
                        child: Row(
                          //mainAxisSize: MainAxisSize.min, 
                          children: [
                            const Text(
                              'Filter',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(Icons.filter_list, color: Colors.black), 
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: MovieCard(selectedGenre: selectedGenre),
                );
              },
              childCount: 1, // Adjust based on the number of movie cards
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => CameraPage()),
          );
          // dbServices.getAges();
        },
        child: const Icon(Icons.face_unlock_sharp),
        backgroundColor: CustomColor.primary,
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

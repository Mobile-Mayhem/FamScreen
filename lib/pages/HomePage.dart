import 'package:famscreen/data/dbMovies.dart';
import 'package:famscreen/pages/ListMoviesPage.dart';
import 'package:famscreen/utils/Colors.dart';
import 'package:famscreen/widgets/MovieCard.dart';
import 'package:flutter/material.dart';
import '../services/databases_services.dart';
import 'FavoritPage.dart';
import 'SearchPage.dart';
import 'HistoryPage.dart';
import 'ProfilPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbServices = DatabasesServices();
  final data = DBMovies().movies;

  int _currentPageIndex = 0;

  final List<Widget> _pages = [
    const ListMoviesPage(),
    FavoritePage(),
    SearchPage(),
    HistoryPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPageIndex], // Mengubah halaman berdasarkan index
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await dbServices.addData(data[0]);
          for (var movie in data) {
            await dbServices.addData(movie);
          }
        },
        child: const Icon(Icons.add),
        backgroundColor: CustomColor.primary,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index; // Memperbarui halaman saat di-klik
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: CustomColor.primary,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorit'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}

/// Halaman Konten HomePage (agar lebih modular)
// class HomePageContent extends StatelessWidget {
//   const HomePageContent({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       physics: const AlwaysScrollableScrollPhysics(),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 16),
//             const Text(
//               'Rekomendasi',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 16),
//             MovieCard(),
//           ],
//         ),
//       ),
//     );
//   }
// }

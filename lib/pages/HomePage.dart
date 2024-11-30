import 'package:famscreen/pages/AddMoviePage.dart';
import 'package:famscreen/pages/ListMoviesPage.dart';
import 'package:famscreen/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
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
      body: _pages[_currentPageIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => AddMoviePage()),
          );
          // dbServices.getAges();
        },
        child: const Icon(Icons.add_moderator_sharp),
        backgroundColor: CustomColor.primary,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GNav(
          onTabChange: (index) {
            setState(() {
              _currentPageIndex = index; // Memperbarui halaman saat tab diubah
            });
          },
          gap: 5,
          rippleColor: CustomColor.primary,
          tabActiveBorder: Border.all(color: CustomColor.primary, width: 2),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          iconSize: 25,
          tabs: [
            GButton(
              icon: LineIcons.home,
              text: 'Home',
            ),
            GButton(
              icon: LineIcons.heart,
              text: 'Likes',
            ),
            GButton(
              icon: LineIcons.search,
              text: 'Search',
            ),
            GButton(
              icon: LineIcons.clock,
              text: 'History',
            ),
            GButton(
              icon: LineIcons.user,
              text: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

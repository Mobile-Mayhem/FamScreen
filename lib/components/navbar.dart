import 'package:flutter/material.dart';
import '../pages/HomePage.dart';
import '../pages/FavoritPage.dart';
import '../pages/SearchScreen.dart';
import '../pages/HistoryPage.dart';
import '../pages/ProfilPage.dart';

class CustomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  const CustomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onDestinationSelected,
  }) : super(key: key);

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  final List<Widget> _pages = [
    HomePage(),
    FavoritPage(),
    SearchScreen(),
    HistoryPage(),
    ProfilePage(),
  ];

  // Fungsi untuk menangani perubahan halaman
  void _navigateToPage(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => _pages[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: Colors.white,
      onDestinationSelected: (index) {
        _navigateToPage(index); // Memanggil fungsi navigasi
        widget.onDestinationSelected(index);
      },
      selectedIndex: widget.currentIndex,
      destinations: <Widget>[
        NavigationDestination(
          icon: Image.asset(
            'assets/icons/home.png',
            width: 30,
            height: 30,
          ),
          label: "",
          selectedIcon: Image.asset(
            'assets/icons/home_selected.png',
            width: 30,
            height: 30,
          ),
        ),
        NavigationDestination(
          icon: Image.asset(
            'assets/icons/heart.png',
            width: 30,
            height: 30,
          ),
          label: "",
          selectedIcon: Image.asset(
            'assets/icons/heart_selected.png',
            width: 30,
            height: 30,
          ),
        ),
        NavigationDestination(
          icon: Image.asset(
            'assets/icons/search.png',
            width: 30,
            height: 30,
          ),
          label: "",
          selectedIcon: Image.asset(
            'assets/icons/search_selected.png',
            width: 30,
            height: 30,
          ),
        ),
        NavigationDestination(
          icon: Image.asset(
            'assets/icons/history.png',
            width: 30,
            height: 30,
          ),
          label: "",
          selectedIcon: Image.asset(
            'assets/icons/history_selected.png',
            width: 30,
            height: 30,
          ),
        ),
        NavigationDestination(
          icon: Image.asset(
            'assets/icons/profile.png',
            width: 30,
            height: 30,
          ),
          label: "",
          selectedIcon: Image.asset(
            'assets/icons/profile.png',
            width: 30,
            height: 30,
          ),
        ),
      ],
    );
  }
}

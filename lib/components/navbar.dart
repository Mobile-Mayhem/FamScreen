import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  const CustomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onDestinationSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: Colors.white,
      onDestinationSelected: onDestinationSelected,
      selectedIndex: currentIndex,
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
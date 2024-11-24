import 'package:flutter/widgets.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import '../utils/Colors.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
    required int currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: GNav(
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
    );
  }
}

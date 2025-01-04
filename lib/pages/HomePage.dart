import 'package:famscreen/pages/ListMoviesPage.dart';
import 'package:famscreen/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Add GetX import
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import '../controllers/HomePageController.dart';
import '../services/databases_services.dart';
import 'FavoritPage.dart';
import 'SearchPage.dart';
import 'HistoryPage.dart';
import 'ProfilPage.dart';

class HomePage extends StatelessWidget {
  final dbServices = DatabasesServices();

  @override
  Widget build(BuildContext context) {
    // Create GetX controller to manage current page index
    final HomePageController controller = Get.put(HomePageController());

    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller
              .currentPageIndex.value, // Use GetX state for page index
          children: [
            const ListMoviesPage(),
            FavoritePage(),
            SearchPage(),
            HistoryPage(),
            const ProfilePage(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GNav(
          onTabChange: (index) {
            controller.changePage(index); // Change page using GetX controller
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

import 'package:famscreen/pages/CameraPage.dart';
import 'package:famscreen/pages/FavoritPage.dart';
import 'package:famscreen/pages/HistoryPage.dart';
import 'package:famscreen/pages/HomePage.dart';
import 'package:famscreen/pages/ListMoviesPage.dart';
import 'package:famscreen/pages/LoginPage.dart';
import 'package:famscreen/pages/OnBoardingPage.dart';
import 'package:famscreen/pages/ProfilPage.dart';
import 'package:famscreen/pages/RegisterPage.dart';
import 'package:famscreen/pages/ResetPasswordPage.dart';
import 'package:famscreen/pages/SearchPage.dart';
import 'package:famscreen/pages/VideoPlayerPage.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: '/',
      page: () => OnBoardingPage(),
    ),
    GetPage(
      name: '/register',
      page: () => RegisterPage(),
    ),
    GetPage(name: '/login', page: () => LoginPage()),
    GetPage(
      name: '/home',
      page: () => HomePage(),
    ),
    GetPage(
      name: '/camera',
      page: () => CameraPage(),
    ),
    GetPage(
      name: '/history',
      page: () => HistoryPage(),
    ),
    GetPage(
      name: '/search',
      page: () => SearchPage(),
    ),
    GetPage(
      name: '/favorit',
      page: () => FavoritePage(),
    ),
    GetPage(
      name: '/profile',
      page: () => ProfilePage(),
    ),
    GetPage(
      name: '/reset-pw',
      page: () => ResetPasswordPage(),
    ),
    GetPage(
      name: '/list',
      page: () => ListMoviesPage(),
    ),
    GetPage(
      name: '/video-player',
      page: () => VideoPlayerPage(
        url: Get.arguments['url'],
        ageCatMovie: Get.arguments['ageCatMovie'],
      ),
    ),
  ];
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:famscreen/services/fav_movies_services.dart';
import 'package:famscreen/services/user_services.dart';

class FavoriteController extends GetxController {
  var favoriteMovies = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    isLoading.value = true;
    try {
      var movies = await FavMoviesServices().getFavMovies();
      favoriteMovies.assignAll(movies);
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Gagal memuat film favorit: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removeFavorite(String title) async {
    try {
      await UserServices().removeFav(title);
      Fluttertoast.showToast(
        msg: '$title Dihapus Dari Favorit',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      loadFavorites();
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Gagal menghapus film favorit: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}

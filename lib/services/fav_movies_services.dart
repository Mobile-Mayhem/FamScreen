import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavMoviesServices {
  final String _favKey = 'favorite_movies';

  Future<void> addFav(Map<String, dynamic> movie) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Ambil daftar favorit yang ada
    List<String> favMovies = prefs.getStringList(_favKey) ?? [];

    // Cek apakah movie sudah ada dalam favorit
    if (favMovies.any((item) => jsonDecode(item)['judul'] == movie['judul'])) {
      print('Movie already in favorites');
      return;
    }

    // Tambahkan movie ke daftar favorit
    favMovies.add(jsonEncode(movie));
    await prefs.setStringList(_favKey, favMovies);
    print('Added to favorites: ${movie['judul']}');
  }

  Future<List<Map<String, dynamic>>> getFavMovies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Ambil daftar favorit yang ada
    List<String> favMovies = prefs.getStringList(_favKey) ?? [];
    return favMovies
        .map((item) => jsonDecode(item) as Map<String, dynamic>)
        .toList();
  }

  Future<void> removeFav(String title) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Ambil daftar favorit
    List<String> favMovies = prefs.getStringList(_favKey) ?? [];

    // Filter daftar favorit untuk menghapus movie
    favMovies.removeWhere((item) => jsonDecode(item)['judul'] == title);
    await prefs.setStringList(_favKey, favMovies);
    print('Removed from favorites: $title');
  }

// Fungsi untuk mengecek apakah film sudah ada di favorit
  Future<bool> isMovieFav(Map<String, dynamic> movie) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favMovies = prefs.getStringList(_favKey) ?? [];

    return favMovies.any((item) => jsonDecode(item)['judul'] == movie['judul']);
  }
}

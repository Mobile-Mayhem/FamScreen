import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HistoryServices {
  final String _historyKey = 'history_movies';

  Future<void> addHistory(Map<String, dynamic> movie) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Ambil daftar history yang ada
    List<String> historyMovies = prefs.getStringList(_historyKey) ?? [];

    // Cek apakah film sudah ada di history
    if (historyMovies
        .any((item) => jsonDecode(item)['judul'] == movie['judul'])) {
      print('Movie already in history');
      return;
    }

    // Tambahkan film ke daftar history
    historyMovies.add(jsonEncode(movie));
    await prefs.setStringList(_historyKey, historyMovies);
    print('Added to history: ${movie['judul']}');
  }

  Future<List<Map<String, dynamic>>> getHistoryMovies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Ambil daftar history yang ada
    List<String> historyMovies = prefs.getStringList(_historyKey) ?? [];
    return historyMovies
        .map((item) => jsonDecode(item) as Map<String, dynamic>)
        .toList();
  }

  Future<void> clearHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
    print('History cleared');
  }
}

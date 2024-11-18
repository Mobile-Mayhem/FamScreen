import 'package:famscreen/data/models/film.dart';
import 'package:flutter/material.dart';

class FavoriteFilmsProvider with ChangeNotifier {
  List<Film> _favoriteFilms = [];

  List<Film> get favoriteFilms => _favoriteFilms;

  void toggleFavorite(Film film) {
    if (_favoriteFilms.contains(film)) {
      _favoriteFilms.remove(film);
    } else {
      _favoriteFilms.add(film);
    }
    notifyListeners();
  }
}

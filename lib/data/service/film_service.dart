import 'package:projek/data/provider/film_api.dart';
import 'package:projek/data/models/film.dart';

class FilmService {
  final _api = FilmApi();
  Future<List<Film>?> getFilms() async {
    return _api.getFilms();
  }
}

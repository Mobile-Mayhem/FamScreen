import '/data/provider/film_api.dart';
import '/data/models/film.dart';

class FilmService {
  final _api = FilmApi();
  Future<List<Film>?> getFilms() async {
    return _api.getFilms();
  }
}

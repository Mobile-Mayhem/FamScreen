import '../provider/film_provider.dart';
import '/data/models/film.dart';

class FilmService {
  final _api = FilmProvider();
  Future<List<Film>?> getFilms() async {
    return _api.getFilms();
  }

  Future<List<Film>> searchFilms(String judul) async {
    final allFilms = await getFilms();
    if (allFilms == null) {
      return [];
    }

    return allFilms
        .where((film) => film.judul.toLowerCase().contains(judul.toLowerCase()))
        .toList();
  }
}

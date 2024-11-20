import '../data/service/film_service.dart';

class MovieService {
  Future<void> loadFilms() async {
    final filmService = FilmService();
    films = await filmService.getFilms();
    setState(() {
      isLoaded = true;
      displayedFilms = films;
    });
  }
}

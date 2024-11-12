import 'dart:convert';
import '/data/models/film.dart';
import 'package:http/http.dart' as http;

class FilmApi {
  Future<List<Film>?> getFilms() async {
    var client = http.Client();
    var uri = Uri.parse('http://128.199.78.57/anak');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      return filmFromJson(const Utf8Decoder().convert(response.bodyBytes));
    }
    return null;
  }
}

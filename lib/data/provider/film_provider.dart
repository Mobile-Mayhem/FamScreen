import 'dart:convert';
import '/data/models/film.dart';
import 'package:http/http.dart' as http;
import '../models/film.dart'; // Assuming filmFromJson is defined in this file

class FilmProvider {
  Future<List<Film>?> getFilms() async {
    var client = http.Client();
    var uri = Uri.parse('http://127.0.0.1:8005/movie');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      return filmFromJson(const Utf8Decoder().convert(response.bodyBytes));
    }
    return null;
  }

  Future<List<Film>?> searchFilms(String judul) async {
    var client = http.Client();
    var uri = Uri.parse('http://128.199.78.57/movie?search=$judul');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      return filmFromJson(response.body);
    } else {
      print('Failed to search films: ${response.statusCode}');
      return [];
    }
  }
}

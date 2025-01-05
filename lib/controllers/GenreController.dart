import 'package:get/get.dart';

class GenreController extends GetxController {
  var selectedGenre = 'semua'.obs;

  void updateGenre(String genre) {
    selectedGenre.value = genre;
  }
}

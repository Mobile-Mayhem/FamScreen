import 'package:flutter/material.dart';

import 'databases_services.dart';

// Kelas layanan untuk kontrol usia
class AgeControlServices {
  List<String> _age = [];
  String? _previousAgeCategory;

  // Fungsi untuk menetapkan kategori usia berdasarkan kategori film
  void setAges(BuildContext context) {
    // Mengambil kategori usia terkini dari DatabasesServices
    String moviesRec = DatabasesServices().moviesRec;

    // Logika untuk memeriksa apakah ada perubahan kategori usia
    if (_previousAgeCategory != null && _previousAgeCategory != moviesRec) {
      print("Perubahan kategori usia terdeteksi!");

      // Menampilkan pop-up jika usia berpindah ke kategori yang lebih rendah
      _handleAgeCategoryChange(moviesRec, context);
    }

    // Menyimpan kategori usia terakhir
    _previousAgeCategory = moviesRec;
  }

  // Fungsi untuk menangani perubahan kategori usia
  void _handleAgeCategoryChange(String newCategory, BuildContext context) {
    if (_isAgeLower(newCategory)) {
      // Menampilkan pop-up jika usia berpindah ke kategori yang lebih rendah
      _showAgeMismatchDialog(context);
    } else {
      print("Kategori usia tetap sesuai: $newCategory");
    }
  }

  // Fungsi untuk memeriksa apakah kategori usia baru lebih rendah
  bool _isAgeLower(String newCategory) {
    if (_previousAgeCategory == "Dewasa" && newCategory == "Remaja") {
      return true;
    } else if (_previousAgeCategory == "Remaja" && newCategory == "Anak-anak") {
      return true;
    }
    return false;
  }

  // Fungsi untuk menampilkan pop-up bahwa usia tidak sesuai
  void _showAgeMismatchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Usia Tidak Sesuai"),
          content: Text(
              "Usia yang terdeteksi tidak sesuai dengan kategori film yang ditonton."),
          actions: <Widget>[
            TextButton(
              child: Text("Tutup"),
              onPressed: () {
                Navigator.of(context).pop(); // Menutup pop-up
              },
            ),
          ],
        );
      },
    );
  }
}

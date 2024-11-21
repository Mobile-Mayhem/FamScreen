// To parse this JSON data, do
//
//     final film = filmFromJson(jsonString);

import 'dart:convert';

List<Film> filmFromJson(String str) =>
    List<Film>.from(json.decode(str).map((x) => Film.fromJson(x)));

String filmToJson(List<Film> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Film {
  int id;
  String posterPotrait;
  String posterLandscap;
  String judul;
  String genre;
  String deskripsi;
  String tahunRilis;
  int durasi;
  String rateImdb;
  String jenis;
  String kategoriUsia;
  String linkStreaming;
  DateTime createdAt;
  DateTime updatedAt;

  Film({
    required this.id,
    required this.posterPotrait,
    required this.posterLandscap,
    required this.judul,
    required this.genre,
    required this.deskripsi,
    required this.tahunRilis,
    required this.durasi,
    required this.rateImdb,
    required this.jenis,
    required this.kategoriUsia,
    required this.linkStreaming,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Film.fromJson(Map<String, dynamic> json) => Film(
        id: json["id"],
        posterPotrait: json["poster_potrait"],
        posterLandscap: json["poster_landscap"],
        judul: json["judul"],
        genre: json["genre"],
        deskripsi: json["deskripsi"],
        tahunRilis: json["tahun_rilis"],
        durasi: json["durasi"],
        rateImdb: json["rate_imdb"],
        jenis: json["jenis"],
        kategoriUsia: json["kategori_usia"],
        linkStreaming: json["link_streaming"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "poster_potrait": posterPotrait,
        "poster_landscap": posterLandscap,
        "judul": judul,
        "genre": genre,
        "deskripsi": deskripsi,
        "tahun_rilis": tahunRilis,
        "durasi": durasi,
        "rate_imdb": rateImdb,
        "jenis": jenis,
        "kategori_usia": kategoriUsia,
        "link_streaming": linkStreaming,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

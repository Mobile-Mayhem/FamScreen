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
  DateTime createdAt;
  DateTime updatedAt;
  String poster;
  String judul;
  String deskripsi;
  String tahunRilis;
  int durasi;
  String rateImdb;
  String jenis;
  String kategoriUsia;
  String linkStreaming;

  Film({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.poster,
    required this.judul,
    required this.deskripsi,
    required this.tahunRilis,
    required this.durasi,
    required this.rateImdb,
    required this.jenis,
    required this.kategoriUsia,
    required this.linkStreaming,
  });

  factory Film.fromJson(Map<String, dynamic> json) => Film(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        poster: json["poster"],
        judul: json["judul"],
        deskripsi: json["deskripsi"],
        tahunRilis: json["tahun_rilis"],
        durasi: json["durasi"],
        rateImdb: json["rate_imdb"],
        jenis: json["jenis"],
        kategoriUsia: json["kategori_usia"],
        linkStreaming: json["link_streaming"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "poster": poster,
        "judul": judul,
        "deskripsi": deskripsi,
        "tahun_rilis": tahunRilis,
        "durasi": durasi,
        "rate_imdb": rateImdb,
        "jenis": jenis,
        "kategori_usia": kategoriUsia,
        "link_streaming": linkStreaming,
      };
}

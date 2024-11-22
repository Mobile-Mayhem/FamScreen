// To parse this JSON data, do
//
//     final movies = moviesFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/src/widgets/framework.dart';

Movies moviesFromJson(String str) => Movies.fromJson(json.decode(str));

String moviesToJson(Movies data) => json.encode(data.toJson());

class Movies {
  String posterPotrait;
  String posterLandscap;
  String judul;
  String genre;
  String deskripsi;
  int tahunRilis;
  int durasi;
  double rateImdb;
  String jenis;
  String ratingFilm;
  String linkStreaming;

  Movies({
    required this.posterPotrait,
    required this.posterLandscap,
    required this.judul,
    required this.genre,
    required this.deskripsi,
    required this.tahunRilis,
    required this.durasi,
    required this.rateImdb,
    required this.jenis,
    required this.ratingFilm,
    required this.linkStreaming,
  });

  factory Movies.fromJson(Map<String, dynamic> json) => Movies(
        posterPotrait: json["poster_potrait"],
        posterLandscap: json["poster_landscap"],
        judul: json["judul"],
        genre: json["genre"],
        deskripsi: json["deskripsi"],
        tahunRilis: json["tahun_rilis"],
        durasi: json["durasi"],
        rateImdb: json["rate_imdb"]?.toDouble(),
        jenis: json["jenis"],
        ratingFilm: json["rating_film"],
        linkStreaming: json["link_streaming"],
      );

  Map<String, dynamic> toJson() => {
        "poster_potrait": posterPotrait,
        "poster_landscap": posterLandscap,
        "judul": judul,
        "genre": genre,
        "deskripsi": deskripsi,
        "tahun_rilis": tahunRilis,
        "durasi": durasi,
        "rate_imdb": rateImdb,
        "jenis": jenis,
        "rating_film": ratingFilm,
        "link_streaming": linkStreaming,
      };
}

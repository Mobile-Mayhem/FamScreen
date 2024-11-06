import 'package:flutter/material.dart';
import 'package:projek/data/models/film.dart';
import 'package:projek/data/service/film_service.dart';

class TestApi extends StatefulWidget {
  const TestApi({super.key});

  @override
  State<TestApi> createState() => _TestApiState();
}

class _TestApiState extends State<TestApi> {
  List<Film>? films;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();

    loadCountries();
  }

  Future<void> loadCountries() async {
    final filmService = FilmService();
    films = await filmService.getFilms();
    setState(() {
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoaded && films != null
          ? SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: films!
                              .map(
                                (films) => Column(
                                  children: [
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Text(films.judul ??
                                                'Tidak ada judul')),
                                        Expanded(
                                          child: Text(films.deskripsi != null &&
                                                  films.tahunRilis!.isNotEmpty
                                              ? films.rateImdb!
                                              : 'No Rate'),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    const Divider(),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

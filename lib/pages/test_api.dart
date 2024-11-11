import 'package:flutter/material.dart';
import '/data/models/film.dart';
import '/data/service/film_service.dart';

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

    loadFilms();
  }

  Future<void> loadFilms() async {
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
                                        Expanded(child: Text(films.judul)),
                                        Expanded(
                                          child: Text(
                                              films.tahunRilis.isNotEmpty
                                                  ? films.rateImdb
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

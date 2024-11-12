import 'package:famscreen/components/expandable_text.dart';
import 'package:famscreen/data/service/film_service.dart';
import 'package:famscreen/pages/HomePage.dart';
import 'package:flutter/material.dart';
import '../data/models/film.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  final Film film;

  DetailPage({Key? key, required this.film}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isFavorite = false;
  List<Film> favoriteFilms = [];
  List<Film> displayedFilms = []; 
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
      displayedFilms = films ?? [];
    });
  }

  void _launchStreamingUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}


  Widget _buildMovieCard(Film film) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(film: film),
          ),
        );
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              film.poster,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
      if (isFavorite) {
        favoriteFilms.add(widget.film);
      } else {
        favoriteFilms.remove(widget.film);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.network(
            widget.film.poster,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(top: 210),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: Container(
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                            (route) => false, //  menghapus semua halaman di stack
                          );
                        },
                      ),
                    ),
                  ),
                  actions: [
                    Container(
                      width: 55,
                      //height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white.withOpacity(0.3),
                        shape: BoxShape.rectangle,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.white,
                          ),
                          onPressed: _toggleFavorite,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 230, left: 25, right: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(widget.film.tahunRilis, style: const TextStyle(fontSize: 16)),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: const Color(0xffF5C518),
                      ),
                      child: const Text('IMDb',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 8),
                    Text('${widget.film.rateImdb}  |', style: const TextStyle(fontSize: 16)),
                    const SizedBox(width: 8),
                    Text('${widget.film.durasi} menit', style: const TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  widget.film.judul,
                  style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                ExpandableText(
                  text: widget.film.deskripsi,
                  maxWords: 45,
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 228, 227, 227),
                      ),
                      child: const Text('Ini', style: TextStyle(fontSize: 14)),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 228, 227, 227),
                      ),
                      child: const Text('Belum', style: TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  'LIHAT SEKARANG',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _launchStreamingUrl(widget.film.linkStreaming); // URL dari model Film
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/images/netflix.png',
                          width: 60,
                          height: 60,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  'Rekomendasi Lainnya',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.6, 
                      mainAxisSpacing: 0.8,
                      crossAxisSpacing: 18,
                    ),
                    itemCount: displayedFilms.length, 
                    itemBuilder: (context, index) {
                      return _buildMovieCard(displayedFilms[index]);
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

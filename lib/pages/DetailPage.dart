import 'package:famscreen/pages/VideoPlayerPage.dart';
import 'package:famscreen/services/fav_movies_services.dart';
import 'package:famscreen/utils/Colors.dart';
import 'package:famscreen/widgets/OtherMovieCard.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../components/ImdbComponent.dart';
import '../components/MovieGenre.dart';
import '../services/history_services.dart';
import '../widgets/ShapePutihDetail.dart';

class DetailPage extends StatefulWidget {
  final Map<String, dynamic> movie;
  const DetailPage({Key? key, required this.movie}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<bool> _isFavoriteFuture;
  late FlickManager flickManager;
  late String url;
  int _selectedTab = 0; // 0 for Recommendations, 1 for Comments

  @override
  void initState() {
    super.initState();
    url = widget.movie['link_streaming'];
    _isFavoriteFuture = FavMoviesServices().isMovieFav(widget.movie);
    flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.networkUrl(
      Uri.parse(url),
    ));
  }

  void _toggleFavorite() async {
    bool isFavorite = await _isFavoriteFuture;
    if (!isFavorite) {
      await FavMoviesServices().addFav(widget.movie);
    } else {
      await FavMoviesServices().removeFav(widget.movie['judul']);
    }
    setState(() {
      _isFavoriteFuture = FavMoviesServices().isMovieFav(widget.movie);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      body: Stack(
        children: [
          Image.network(
            widget.movie['poster_landscap'],
            width: double.infinity,
            height: 300,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: Image.asset(
                  'assets/imgnotfound.png',
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
          ShapePutihDetail(),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBarDetail(context),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 260, left: 25, right: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(widget.movie['tahun_rilis']?.toString() ?? '',
                        style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 8),
                    ImdbComponent(),
                    const SizedBox(width: 8),
                    Text((widget.movie['rate_imdb']?.toString() ?? '') + '   | ',
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(width: 8),
                    Text((widget.movie['durasi']?.toString() ?? '') + ' menit',
                        style: TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  widget.movie['judul']?.toString() ?? '',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.movie['deskripsi']?.toString() ?? '',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 15),
                MovieGenre(movie: widget.movie),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 310,
                      height: 45,
                      child: TextButton.icon(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullscreenVideoPage(url: url), 
                            ),
                          );
                          await HistoryServices().addHistory(widget.movie);
                        },
                        icon: const Icon(
                          Icons.play_circle_fill,
                          color: Colors.black,
                        ),
                        label: const Text(
                          'Lihat Sekarang',
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: CustomColor.primary,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,  
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedTab = 0;
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            'Rekomendasi Lainnya',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: _selectedTab == 0 ? Colors.black : Colors.grey,
                            ),
                          ),
                          SizedBox(height: 4),  
                          Container(
                            height: 2,
                            width: 160,  
                            color: _selectedTab == 0 ? CustomColor.primary : Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedTab = 1;
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            'Komentar',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: _selectedTab == 1 ? Colors.black : Colors.grey,
                            ),
                          ),
                          SizedBox(height: 4),
                          Container(
                            height: 2,
                            width: 100,  
                            color: _selectedTab == 1 ? CustomColor.primary : Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                  _selectedTab == 0
                      ? SizedBox(
                          height: 150,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              OtherMovieCard(),
                            ],
                          ),
                        )
                      : Column(
                          children: [
                          ],
                        ),

              ],
            ),
          )
        ],
      ),
    );
  }

  AppBar AppBarDetail(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Container(
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      actions: [
        FutureBuilder<bool>(
          future: _isFavoriteFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            bool isFavorite = snapshot.data ?? false;

            return Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.white,
                ),
                onPressed: _toggleFavorite,
              ),
            );
          },
        ),
      ],
    );
  }
}

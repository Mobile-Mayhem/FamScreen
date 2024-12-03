import 'package:famscreen/services/fav_movies_services.dart';
import 'package:famscreen/utils/Colors.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../components/MovieGenre.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/history_services.dart';

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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(2.0),
        child: AppBarDetail(context),
      ),
      body: Stack(
        children: [
          Container(
            height: 210,
            child: AspectRatio(
              aspectRatio: flickManager
                  .flickVideoManager!.videoPlayerController!.value.aspectRatio,
              child: FlickVideoPlayer(flickManager: flickManager),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(top: 210),
            decoration: const BoxDecoration(
              color: CustomColor.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBarDetail(context),
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
                    Text(widget.movie['tahun_rilis']?.toString() ?? '',
                        style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: const Color(0xffF5C518),
                      ),
                      child: const Text('IMDb',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 8),
                    Text(widget.movie['rate_imdb']?.toString() ?? '' + ' |',
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(width: 8),
                    Text(widget.movie['durasi']?.toString() ?? '' + ' menit',
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
                const SizedBox(height: 14),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        String url = widget.movie['link_streaming'];
                        print(widget.movie['link_streaming']);
                        await HistoryServices().addHistory(widget.movie);
                        // if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url));
                        // } else {
                        //   print("Could not launch URL");
                        // }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/images/netflix.png',
                          width: 50,
                          height: 50,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  'Rekomendasi Lainnya',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(15)),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
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
                color: Colors.white.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.black,
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famscreen/pages/VideoPlayerPage.dart';
import 'package:famscreen/services/fav_movies_services.dart';
import 'package:famscreen/services/sync_services.dart';
import 'package:famscreen/utils/Colors.dart';
import 'package:famscreen/widgets/AppBarDetail.dart';
import 'package:famscreen/widgets/CommentCard.dart';
import 'package:famscreen/widgets/OtherMovieCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../components/ImdbComponent.dart';
import '../components/MovieGenre.dart';

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
  late String ageCatMovie;
  int _selectedTab = 0;
  late YoutubePlayerController _youtubeController;
  late Future<List<Map<String, dynamic>>> _commentsFuture;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  //List<String> get selectedGenres => List<String>.from(widget.movie['genres'] ?? []);

  @override
  void initState() {
    super.initState();

    _commentsFuture = fetchComments();

    // youtube player
    _youtubeController = YoutubePlayerController(
      initialVideoId:
          YoutubePlayer.convertUrlToId(widget.movie['poster_landscap']) ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    // flickplayer
    url = widget.movie['link_streaming'];
    ageCatMovie = widget.movie['kategori_usia'];
    _isFavoriteFuture = FavMoviesServices().isMovieFav(widget.movie);
    flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.networkUrl(
      Uri.parse(url),
    ));
  }

  Future<List<Map<String, dynamic>>> fetchComments() async {
    final response =
        await CommentService().fetchCommentsForMovie(widget.movie['judul']);
    print(response);
    return response;
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }

  void _toggleFavorite() async {
    bool isFavorite = await _isFavoriteFuture;
    if (!isFavorite) {
      await SyncServices().addFav(widget.movie);
    } else {
      await SyncServices().removeFav(widget.movie['judul']);
    }
    setState(() {
      _isFavoriteFuture = FavMoviesServices().isMovieFav(widget.movie['judul']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          YoutubePlayer(
            controller: _youtubeController,
            showVideoProgressIndicator: true,
            bottomActions: [
              CurrentPosition(),
              ProgressBar(
                isExpanded: true,
                colors: ProgressBarColors(
                  playedColor: Colors.amber,
                  handleColor: Colors.amberAccent,
                  backgroundColor: Colors.grey.shade700,
                  bufferedColor: Colors.grey.shade400,
                ),
              ),
              PlaybackSpeedButton(),
            ],
          ),

          Positioned(
            top: 0, // Sesuaikan posisi AppBar
            left: 0,
            right: 0,
            child: AppBarDetail(
              isFavoriteFuture: _isFavoriteFuture,
              toggleFavorite: _toggleFavorite,
            ),
          ),
          // Align(
          //   alignment: Alignment.topCenter,
          //   child: Container(
          //     margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.253),
          //     child: ShapePutihDetail(),
          //   ),
          // ),
          ClipRect(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.71,
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            //top: MediaQuery.of(context).size.height * 0.07,
                            left: MediaQuery.of(context).size.width * 0.06,
                            right: MediaQuery.of(context).size.width * 0.06,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                      widget.movie['tahun_rilis']?.toString() ??
                                          '',
                                      style: TextStyle(fontSize: 16)),
                                  const SizedBox(width: 8),
                                  ImdbComponent(),
                                  const SizedBox(width: 8),
                                  Text(
                                      (widget.movie['rate_imdb']?.toString() ??
                                              '') +
                                          '   | ',
                                      style: const TextStyle(fontSize: 16)),
                                  const SizedBox(width: 8),
                                  Text(
                                      (widget.movie['durasi']?.toString() ??
                                              '') +
                                          ' menit   |   ',
                                      style: TextStyle(fontSize: 16)),
                                  Text(
                                      (widget.movie['kategori_usia']
                                              ?.toString() ??
                                          ''),
                                      style: TextStyle(fontSize: 16)),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                widget.movie['judul']?.toString() ?? '',
                                style: TextStyle(
                                    fontSize: 26, fontWeight: FontWeight.w900),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                widget.movie['deskripsi']?.toString() ?? '',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black54),
                              ),
                              const SizedBox(height: 15),
                              MovieGenre(movie: widget.movie),
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                FullscreenVideoPage(
                                              url: url,
                                              ageCatMovie: ageCatMovie,
                                            ),
                                          ),
                                        );
                                        await SyncServices().addHistory(
                                            widget.movie,
                                            Timestamp.fromDate(DateTime.now()));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.play_circle_fill,
                                            color: Colors.black,
                                          ),
                                          const SizedBox(width: 8),
                                          const Text(
                                            'Lihat Sekarang',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: CustomColor.primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        minimumSize: const Size(309, 50),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8.0),
                                        elevation: 0,
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
                                            color: _selectedTab == 0
                                                ? Colors.black
                                                : Colors.grey,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Container(
                                          height: 2,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          color: _selectedTab == 0
                                              ? CustomColor.primary
                                              : Colors.transparent,
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
                                            color: _selectedTab == 1
                                                ? Colors.black
                                                : Colors.grey,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Container(
                                          height: 2,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          color: _selectedTab == 1
                                              ? CustomColor.primary
                                              : Colors.transparent,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              _selectedTab == 0
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        OtherMovieCard(),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        CommentCard(
                                            commentsFuture: _commentsFuture),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../controllers/DetailController.dart';
import '../utils/Colors.dart';

class DetailPage extends GetView<DetailController> {
  final Map<String, dynamic> movie; // Tambahkan parameter movie

  // Konstruktor untuk menerima parameter movie
  const DetailPage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DetailController());

    controller.movie.value = movie;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          YoutubePlayer(
            controller: controller.youtubeController!,
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
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              title: Text(controller.movie['judul']),
              actions: [
                Obx(
                  () => IconButton(
                    icon: Icon(
                      controller.isFavorite.value
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: controller.toggleFavorite,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.movie['judul'] ?? '',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    controller.movie['deskripsi'] ?? '',
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed('/full-video', arguments: {
                        'url': controller.movie['link_streaming'],
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.play_circle_fill, color: Colors.black),
                        SizedBox(width: 8),
                        Text(
                          'Lihat Sekarang',
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColor.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      minimumSize: const Size(309, 50),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8.0),
                      elevation: 0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

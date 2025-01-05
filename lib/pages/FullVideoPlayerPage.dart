import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../controllers/FullVideoPlayerController.dart';

class FullVideoPlayerPage extends StatelessWidget {
  final String url;
  final String ageCatMovie;

  FullVideoPlayerPage({required this.url, required this.ageCatMovie});

  @override
  Widget build(BuildContext context) {
    final videoController = Get.put(
        FullVideoPlayerController(videoUrl: url, ageCatMovie: ageCatMovie));

    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        if (!videoController.isCameraInitialized.value) {
          return Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            Expanded(
              child: FlickVideoPlayer(
                flickManager: FlickManager(
                  videoPlayerController: VideoPlayerController.network(url),
                ),
              ),
            ),
            Text('Kategori Umur: ${videoController.ageCategory.value}',
                style: TextStyle(color: Colors.white)),
          ],
        );
      }),
    );
  }
}

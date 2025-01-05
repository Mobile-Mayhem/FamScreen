import 'package:flick_video_player/flick_video_player.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailController extends GetxController {
  final movie = {}.obs;
  FlickManager? flickManager;
  YoutubePlayerController? youtubeController;

  final isFavorite = false.obs;

  // Method untuk menerima movie dari DetailPage
  void setMovie(Map<String, dynamic> movieData) {
    movie.value = movieData;

    // Inisialisasi Youtube Player jika ada URL video
    String videoId = '';
    if (movie['poster_landscap'] != null) {
      videoId = YoutubePlayer.convertUrlToId(movie['poster_landscap']) ?? '';
    }

    // Inisialisasi youtubeController hanya jika videoId valid
    if (videoId.isNotEmpty) {
      youtubeController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      );
    }

    // Pastikan link streaming valid sebelum memulai Flick Manager
    if (movie['link_streaming'] != null) {
      flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.networkUrl(
          Uri.parse(movie['link_streaming']),
        ),
      );
    } else {
      flickManager = FlickManager(
        videoPlayerController:
            VideoPlayerController.asset('assets/placeholder_video.mp4'),
      );
    }
  }

  void toggleFavorite() {
    isFavorite.toggle(); // Toggle status favorit
  }

  @override
  void onClose() {
    youtubeController?.dispose(); // Null check sebelum dispose
    flickManager?.dispose(); // Null check sebelum dispose
    super.onClose();
  }
}

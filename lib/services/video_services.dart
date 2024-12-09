import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flick_video_player/flick_video_player.dart';

class VideoServices extends ChangeNotifier {
  late FlickManager flickManager;
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  void initialize(String url) {
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(url),
    );
    _isInitialized = true;
    notifyListeners();
  }

  void disposeFlickManager() {
    flickManager.dispose();
  }

  Future<void> captureAndSendImage() async {
    // Logika untuk mengambil gambar
    print("Image captured and sent to server!");
  }
}

import 'package:famscreen/services/video_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flick_video_player/flick_video_player.dart';

class FullscreenVideoPage extends StatefulWidget {
  final String url;

  const FullscreenVideoPage({required this.url});

  @override
  _FullscreenVideoPageState createState() => _FullscreenVideoPageState();
}

class _FullscreenVideoPageState extends State<FullscreenVideoPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = Provider.of<VideoServices>(context, listen: false);
      viewModel.initialize(widget.url);
      _scheduleImageCapture(viewModel);
    });
  }

  bool _isDisposed = false;

  void _scheduleImageCapture(VideoServices viewModel) {
    Future.delayed(Duration(seconds: 10), () async {
      if (_isDisposed) return;
      await viewModel.captureAndSendImage();
      _scheduleImageCapture(viewModel); // Loop kembali
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    final viewModel = Provider.of<VideoServices>(context, listen: false);
    viewModel.disposeFlickManager();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<VideoServices>(
        builder: (context, viewModel, child) {
          if (!viewModel.isInitialized) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Center(
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: FlickVideoPlayer(flickManager: viewModel.flickManager),
            ),
          );
        },
      ),
    );
  }
}

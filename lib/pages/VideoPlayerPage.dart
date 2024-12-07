import 'dart:async';
import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

import '../services/age_control_services.dart';
import '../services/databases_services.dart';

class FullscreenVideoPage extends StatefulWidget {
  final String url;

  FullscreenVideoPage({required this.url});

  @override
  _FullscreenVideoPageState createState() => _FullscreenVideoPageState();
}

class _FullscreenVideoPageState extends State<FullscreenVideoPage> {
  late FlickManager flickManager;
  late CameraController controller;
  bool _isCameraInitialized = false;
  late Timer _timer;
  XFile? _capturedImage;
  final dbServices = DatabasesServices();
  final ageControlServices = AgeControlServices();

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(widget.url),
    );
    _startAutoCapture();
    _initializeCamera();
  }

  bool _isDisposed = false;

  void _startAutoCapture() {
    Future.delayed(Duration(minutes: 3), () async {
      if (_isDisposed) return;
      print("HALOOOOOOOOOOOOOOOOOO");
      // _initializeCamera();
      _takePicture();
      _startAutoCapture();
    });
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        controller = CameraController(
          cameras[1],
          ResolutionPreset.medium,
        );

        await controller.initialize();
        if (!mounted) return;

        setState(() {
          _isCameraInitialized = true;
        });

        _startAutoCapture();
      } else {
        print('No cameras found');
      }
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  Future<void> _takePicture() async {
    try {
      if (!controller.value.isInitialized) {
        print('Error: Camera is not initialized.');
        return;
      }

      if (!controller.value.isTakingPicture) {
        final image = await controller.takePicture();
        setState(() {
          _capturedImage = image;
        });

        await _sendImage();
      }
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  // Kirim gambar ke server
  Future<void> _sendImage() async {
    if (_capturedImage == null) {
      print('Tidak ada gambar yang diambil.');
    }

    final imageFile = _capturedImage!.path;
    final url = Uri.parse('http://128.199.78.57:5000/upload');

    // Kirim gambar ke server
    try {
      var request = http.MultipartRequest('POST', url)
        ..files.add(await http.MultipartFile.fromPath('image', imageFile));
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await http.Response.fromStream(response);
        var jsonData = json.decode(responseData.body);
        print("haloooo");
        print(jsonData);
        int prediction = jsonData['prediction'];
        String ageCategory = '';

        // Periksa nilai prediksi dan tentukan kategori umur
        if (prediction == 0) {
          ageCategory = 'Anak-anak';
        } else if (prediction == 1) {
          ageCategory = 'Remaja';
        } else if (prediction == 2) {
          ageCategory = 'Dewasa';
        } else {
          ageCategory = 'Tidak dapat mendeteksi umur';
        }

        // Simpan hasil prediksi umur ke dalam database
        dbServices.setAges(ageCategory);
        print(ageCategory);
        ageControlServices.setAges(context);
      } else {
        print('Failed to send image to server.');
      }
    } catch (e) {
      print('Error sending image to server: $e');
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    flickManager.dispose();
    controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _takePicture();
        },
        child: Icon(Icons.camera_alt),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: FlickVideoPlayer(flickManager: flickManager),
        ),
      ),
    );
  }
}

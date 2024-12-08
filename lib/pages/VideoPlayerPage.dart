import 'dart:async';
import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';

import '../services/age_control_services.dart';
import '../services/databases_services.dart';

class FullscreenVideoPage extends StatefulWidget {
  final String url;
  final String ageCatMovie;

  FullscreenVideoPage({required this.url, required this.ageCatMovie});

  @override
  _FullscreenVideoPageState createState() => _FullscreenVideoPageState();
}

class _FullscreenVideoPageState extends State<FullscreenVideoPage> {
  late FlickManager flickManager;
  late CameraController controller;
  bool _isCameraInitialized = false;
  late Timer _timer;
  XFile? _capturedImage;
  String ageCategory = '';
  final dbServices = DatabasesServices();
  final ageControl = AgeControlServices();

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
    Future.delayed(Duration(seconds: 40), () async {
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

    final url = Uri.parse('http://128.199.78.57:5000/upload');

    // Kirim gambar ke server
    try {
      var request = http.MultipartRequest('POST', url);
      request.files.add(
          await http.MultipartFile.fromPath('image', _capturedImage!.path));
      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await http.Response.fromStream(response);
        var jsonData = json.decode(responseData.body);
        int prediction = jsonData['prediction'];

        // Periksa nilai prediksi dan tentukan kategori umur
        if (prediction == 0) {
          ageCategory = 'Anak-anak';
        } else if (prediction == 1) {
          ageCategory = 'Remaja';
        } else if (prediction == 2 || prediction == 3) {
          ageCategory = 'Dewasa';
        } else {
          ageCategory = 'Tidak dapat mendeteksi umur';
        }

        dbServices.setAges(ageCategory);
        print(ageCategory);
      } else {
        print('Failed to send image to server.');
      }
    } catch (e) {
      print('Error sending image to server: $e');
    }
    _ageControl();
  }

  Future<void> _ageControl() async {
    if (ageCategory == '') {
      print("DATA KOSONG NGAB");
    } else if (widget.ageCatMovie == '18+' && ageCategory == 'Anak-anak' ||
        ageCategory == 'Remaja') {
      // _showAlert(context);
      _showAlertOverlay(context);
      print('LU OLANG GA CUKUP UMUR.');
    } else if (widget.ageCatMovie == '13+' && ageCategory == 'Anak-anak') {
      print('LU OLANG GA CUKUP UMUR.');
      // _showAlert(context);
      _showAlertOverlay(context);
    }
  }

  getAgesCat() {
    print(widget.ageCatMovie);
  }

  void _showAlertOverlay(BuildContext context) {
    final overlayState = Overlay.of(context);
    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: () {
          overlayEntry.remove();
        },
        child: Material(
          color: Colors.black.withOpacity(0.5),
          child: Center(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.warning_amber_rounded,
                      size: 50, color: Colors.red),
                  Text(
                    'Konten Tidak Sesuai Usia',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Maaf, video ini tidak tersedia untuk usia Anda. Silakan pilih konten lain yang sesuai dengan batasan usia Anda.',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      overlayEntry.remove();
                    },
                    child: Text('Tutup'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    overlayState.insert(overlayEntry);
  }

  // Future<void> _showAlert(BuildContext context) async {
  //   QuickAlert.show(
  //     context: context,
  //     type: QuickAlertType.error,
  //     title: 'Konten Tidak Sesuai Usia',
  //     text:
  //         'Maaf, video ini tidak tersedia untuk usia Anda. Silakan pilih konten lain yang sesuai dengan batasan usia Anda.',
  //   );
  // }

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
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            Container(
              height: 300,
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: FlickVideoPlayer(flickManager: flickManager),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  ageCategory = 'Dewasa';
                  print(ageCategory);
                },
                child: const Text('Set Ages Dewasa')),
            ElevatedButton(
                onPressed: () {
                  dbServices.setAges('Anak-anak');
                  _ageControl();
                  print(ageCategory);
                },
                child: const Text('Set Ages anak-anak')),
            ElevatedButton(
                onPressed: () {
                  _takePicture();
                },
                child: const Text('Ambil gambar')),
            ElevatedButton(
                onPressed: () {
                  print(ageCategory);
                  _ageControl();
                },
                child: const Text('Cek umur')),
          ],
        ),
      ),
    );
  }
}

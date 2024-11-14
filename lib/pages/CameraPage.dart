import 'package:camera/camera.dart';
import 'package:famscreen/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils/Colors.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController controller;
  bool _isCameraInitialized = false;
  XFile? _capturedImage;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _sendImage() async {
    if (_capturedImage == null) {
      print('No image to send.');
      return;
    }

    final url = Uri.parse('http://128.199.78.57:8004/upload');

    try {
      var request = http.MultipartRequest('POST', url);
      request.files.add(
          await http.MultipartFile.fromPath('image', _capturedImage!.path));
      var response = await request.send();

      if (response.statusCode == 200) {
        print('Image uploaded successfully.');
      } else {
        print('Image upload failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        controller = CameraController(
          cameras[1],
          ResolutionPreset.max,
        );

        await controller.initialize();

        if (!mounted) return;

        setState(() {
          _isCameraInitialized = true;
        });
      } else {
        print('No cameras found');
      }
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  Future<void> _takePicture() async {
    if (!controller.value.isInitialized) {
      print('Error: Camera is not initialized.');
      return;
    }

    try {
      final image = await controller.takePicture();
      setState(() {
        _capturedImage = image;
      });

      // Send the image to the server
      await _sendImage();
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isCameraInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 100),
            Column(children: [
              Text('Verifikasi Diri',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: CustomColor.black)),
              const SizedBox(height: 30),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 278,
                    height: 278,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: CameraPreview(controller),
                    ),
                  ),
                  Image.asset(
                    'assets/camera_frame.png',
                    width: 255,
                    height: 255,
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Text(
                'Tetaplah berada di posisi ini, harap menunggu pengambilan gambar',
                style: TextStyle(fontSize: 16, color: CustomColor.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 255),
              ElevatedButton(
                onPressed: () {
                  _takePicture();
                  print('Gambar diambil dan dikirim');
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const HomePage()),
                  );
                },
                child: const Text('Ambil Gambar'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  minimumSize: const Size(309, 50),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}

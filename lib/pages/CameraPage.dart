import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'HomePage.dart';
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
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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

    final url = Uri.parse('http://192.168.1.100:8004/upload');

    try {
      var request = http.MultipartRequest('POST', url);
      request.files.add(
          await http.MultipartFile.fromPath('image', _capturedImage!.path));
      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await http.Response.fromStream(response);
        var jsonData = json.decode(responseData.body);

        if (jsonData['status'] == 'success') {
          String prediction = jsonData['prediction'];
          String imageUrl = jsonData['image_url'];

          await _showAlertDialog('Prediction', 'Predicted Age: $prediction');
        } else if (jsonData['status'] == 'failure') {
          String message = jsonData['message'];

          print('Error: $message');
          await _showAlertDialog('Wajah Tidak Terdeteksi', '$message');
        }
      } else {
        print('Image upload failed with status: ${response.statusCode}');
        await _showAlertDialog(
            'Error', 'Image upload failed with status: ${response.statusCode}');
      }
    } catch (e) {
      await _showAlertDialog('Error', 'Error uploading image: $e');
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
    try {
      // Periksa apakah controller siap untuk mengambil gambar
      if (!controller.value.isInitialized) {
        print('Error: Camera is not initialized.');
        return;
      }

      // Ambil gambar hanya jika kamera tidak sedang mengambil gambar
      if (!controller.value.isTakingPicture) {
        final image = await controller.takePicture();
        setState(() {
          // Perbarui _capturedImage dengan gambar yang baru diambil
          _capturedImage = image;
        });

        // Kirim gambar ke server
        await _sendImage();
      }
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  Future<void> _showAlertDialog(String title, String content) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button to dismiss the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(content),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const HomePage()),
                );
              },
            ),
          ],
        );
      },
    );
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
                  // dispose();
                  print('Gambar diambil dan dikirim');
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(builder: (_) => const HomePage()),
                  // );
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

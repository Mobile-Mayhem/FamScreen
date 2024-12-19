import 'dart:convert';

import 'package:camera/camera.dart';
import 'dart:math' as math;
import 'package:famscreen/services/databases_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';

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
  String age = '';
  String ageCategory = '';

  final dbServices = DatabasesServices();

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

    QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      title: 'Loading',
      text: 'Mendeteksi usia Anda',
    );

    // final url = Uri.parse('http://128.199.78.57:5000/upload');
    final url = Uri.parse('https://apif.abdaziz.my.id/upload');

    try {
      var request = http.MultipartRequest('POST', url);
      request.files.add(
          await http.MultipartFile.fromPath('image', _capturedImage!.path));
      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await http.Response.fromStream(response);
        var jsonData = json.decode(responseData.body);
        int prediction = jsonData['prediction'];

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

        Navigator.of(context).pop();
        await _showAlertDialog('Hasil Prediksi', 'Prediksi Umur: $ageCategory');
      } else {
        Navigator.of(context).pop();
        print('Image upload failed with status: ${response.statusCode}');
        await _showWarnDialog(
            'Gagal', 'Wajah Tidak Terdeteksi, silahkan ikuti instruksi');
      }
    } catch (e) {
      Navigator.of(context).pop();
      await _showErrorDialog(
          'Gagal', 'Tidak dapat upload gambar, silahkan coba lagi');
    }
  }

  Future<void> _showWarnDialog(String title, String content) async {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        title: '$title',
        text: '$content',
        onConfirmBtnTap: () => Navigator.of(context).pop());
  }

  Future<void> _showAlertDialog(String title, String content) async {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: '$title',
      text: '$content',
      onConfirmBtnTap: () => Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const HomePage()),
        (route) => false,
      ),
    );
  }

  Future<void> _showErrorDialog(String title, String content) async {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: '$title',
        text: '$content',
        onConfirmBtnTap: () => Navigator.of(context).pop());
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        controller = CameraController(
          cameras[1],
          ResolutionPreset.ultraHigh,
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

      if (!controller.value.isTakingPicture) {
        final image = await controller.takePicture();
        setState(() {
          _capturedImage = image;
        });

        // Kirim gambar ke server
        await _sendImage();
      }
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isCameraInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    final size = MediaQuery.of(context).size;
    var scale = size.aspectRatio * controller.value.aspectRatio;
    if (scale < 1) scale = 1 / scale;

    final double mirror =
        controller.description.lensDirection == CameraLensDirection.front
            ? math.pi
            : 0;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox.expand(
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(mirror),
              child: Transform.scale(
                scale: scale,
                child: Center(
                  child: CameraPreview(controller),
                ),
              ),
            ),
          ),
          Image.asset(
            'assets/camera_frame.png',
            width: 300,
            height: 300,
          ),
          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Verifikasi Diri',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: CustomColor.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 50,
            right: 50,
            child: ElevatedButton(
              onPressed: () {
                _takePicture();
              },
              child: const Text('Ambil Gambar'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                minimumSize: const Size(309, 50),
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.15,
            left: 20,
            right: 20,
            child: Text(
              'Tetaplah berada di posisi ini dan lihat ke kamera, harap tekan tombol Ambil Gambar apabila anda sudah siap',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:async';
import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../services/databases_services.dart';

class FullVideoPlayerController extends GetxController {
  final String videoUrl;
  final String ageCatMovie;

  FullVideoPlayerController(
      {required this.videoUrl, required this.ageCatMovie});

  late CameraController cameraController;
  final dbServices = DatabasesServices();
  final RxBool isCameraInitialized = false.obs;
  final RxString ageCategory = ''.obs;
  XFile? capturedImage;

  @override
  void onInit() {
    super.onInit();
    initializeCamera();
    startAutoCapture();
  }

  Future<void> initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        cameraController = CameraController(
          cameras[1],
          ResolutionPreset.ultraHigh,
        );
        await cameraController.initialize();
        isCameraInitialized.value = true;
      } else {
        print('No cameras found');
      }
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  void startAutoCapture() {
    Timer.periodic(Duration(seconds: 20), (timer) {
      if (!cameraController.value.isInitialized ||
          !cameraController.value.isTakingPicture) {
        takePicture();
      }
    });
  }

  Future<void> takePicture() async {
    try {
      if (!cameraController.value.isInitialized) {
        print('Error: Camera is not initialized.');
        return;
      }

      if (!cameraController.value.isTakingPicture) {
        capturedImage = await cameraController.takePicture();
        sendImage();
      }
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  Future<void> sendImage() async {
    if (capturedImage == null) {
      print('Tidak ada gambar yang diambil.');
      return;
    }

    final url = Uri.parse('https://apif.abdaziz.my.id/upload');

    try {
      var request = http.MultipartRequest('POST', url);
      request.files
          .add(await http.MultipartFile.fromPath('image', capturedImage!.path));
      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await http.Response.fromStream(response);
        var jsonData = json.decode(responseData.body);
        int prediction = jsonData['prediction'];

        ageCategory.value = _determineAgeCategory(prediction);
        dbServices.setAges(ageCategory.value);
        print("Gambar dikirim ke server. ${ageCategory.value}");
        ageControl();
      } else {
        print('Failed to send image to server.');
      }
    } catch (e) {
      print('Error sending image to server: $e');
    }
  }

  String _determineAgeCategory(int prediction) {
    if (prediction == 0) return 'Anak-anak';
    if (prediction == 1) return 'Remaja';
    if (prediction == 2 || prediction == 3) return 'Dewasa';
    return 'Tidak dapat mendeteksi umur';
  }

  void ageControl() {
    if (ageCategory.value == '') return;

    if ((ageCatMovie == '18+' &&
            (ageCategory.value == 'Anak-anak' ||
                ageCategory.value == 'Remaja')) ||
        (ageCatMovie == '13+' && ageCategory.value == 'Anak-anak')) {
      Get.snackbar(
        'Konten Tidak Sesuai Usia',
        'Maaf, video ini tidak sesuai dengan batasan usia Anda.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.primaryColor,
        colorText: Get.theme.colorScheme.onPrimary,
      );
    }
  }

  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
  }
}

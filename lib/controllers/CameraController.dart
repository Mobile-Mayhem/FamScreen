import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:famscreen/routes/AppRoutes.dart';
import 'package:famscreen/services/databases_services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';

class CameraPageController extends GetxController {
  late CameraController cameraController;
  final DatabasesServices dbServices = DatabasesServices();
  final RxBool isCameraInitialized = false.obs;
  final Rx<XFile?> capturedImage = Rx<XFile?>(null);
  final RxString ageCategory = ''.obs;

  @override
  void onInit() {
    super.onInit();
    initializeCamera();
  }

  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
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

  Future<void> takePicture() async {
    try {
      if (!cameraController.value.isInitialized) {
        print('Camera not initialized.');
        return;
      }

      if (!cameraController.value.isTakingPicture) {
        final image = await cameraController.takePicture();
        capturedImage.value = image;
        await sendImage();
      }
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  Future<void> sendImage() async {
    if (capturedImage.value == null) {
      print('No image to send.');
      return;
    }

    QuickAlert.show(
      context: Get.context!,
      type: QuickAlertType.loading,
      title: 'Loading',
      text: 'Mendeteksi usia Anda',
    );

    final url = Uri.parse('https://apif.abdaziz.my.id/upload');

    try {
      var request = http.MultipartRequest('POST', url);
      request.files.add(await http.MultipartFile.fromPath(
          'image', capturedImage.value!.path));
      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await http.Response.fromStream(response);
        var jsonData = json.decode(responseData.body);
        int prediction = jsonData['prediction'];

        if (prediction == 0) {
          ageCategory.value = 'Anak-anak';
        } else if (prediction == 1) {
          ageCategory.value = 'Remaja';
        } else if (prediction == 2 || prediction == 3) {
          ageCategory.value = 'Dewasa';
        } else {
          ageCategory.value = 'Tidak dapat mendeteksi umur';
        }

        dbServices.setAges(ageCategory.value);

        Get.back();
        await showAlertDialog(
            'Hasil Prediksi', 'Prediksi Umur: ${ageCategory.value}');
      } else {
        Get.back();
        print('Image upload failed with status: ${response.statusCode}');
        await showWarnDialog(
            'Gagal', 'Wajah Tidak Terdeteksi, silahkan ikuti instruksi');
      }
    } catch (e) {
      Get.back();
      await showErrorDialog(
          'Gagal', 'Tidak dapat upload gambar, silahkan coba lagi');
    }
  }

  Future<void> showWarnDialog(String title, String content) async {
    QuickAlert.show(
      context: Get.context!,
      type: QuickAlertType.warning,
      title: title,
      text: content,
    );
  }

  Future<void> showAlertDialog(String title, String content) async {
    QuickAlert.show(
      context: Get.context!,
      type: QuickAlertType.success,
      title: title,
      text: content,
      onConfirmBtnTap: () => Get.offAllNamed(AppRoutes.home),
    );
  }

  Future<void> showErrorDialog(String title, String content) async {
    QuickAlert.show(
      context: Get.context!,
      type: QuickAlertType.error,
      title: title,
      text: content,
    );
  }
}

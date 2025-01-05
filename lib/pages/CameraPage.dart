import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/CameraController.dart';
import '../utils/Colors.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CameraPageController controller = Get.put(CameraPageController());

    return Scaffold(
      body: Obx(() {
        if (!controller.isCameraInitialized.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final size = MediaQuery.of(context).size;
        var scale =
            size.aspectRatio * controller.cameraController.value.aspectRatio;
        if (scale < 1) scale = 1 / scale;

        final double mirror =
            controller.cameraController.description.lensDirection ==
                    CameraLensDirection.front
                ? math.pi
                : 0;

        return Stack(
          alignment: Alignment.center,
          children: [
            SizedBox.expand(
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(mirror),
                child: Transform.scale(
                  scale: scale,
                  child: CameraPreview(controller.cameraController),
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
                  const SizedBox(height: 40),
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
                onPressed: () => controller.takePicture(),
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
        );
      }),
    );
  }
}

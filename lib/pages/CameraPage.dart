import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';

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

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Picture saved to ${image.path}'),
          duration: const Duration(seconds: 2),
        ),
      );
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
      appBar: AppBar(title: const Text('Camera Page')),
      body: Column(
        children: [
          if (_capturedImage != null)
            Expanded(
              child: Image.file(
                File(_capturedImage!.path),
                fit: BoxFit.cover,
              ),
            )
          else
            Expanded(
              child: AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: CameraPreview(controller),
              ),
            ),
          SizedBox(height: 100),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _takePicture();
        },
        child: const Icon(Icons.camera),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

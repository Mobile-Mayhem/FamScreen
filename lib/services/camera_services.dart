import 'dart:io';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class CameraServices {
  CameraController? _controller;
  List<CameraDescription>? _cameras;

  // Mengambil daftar kamera yang tersedia
  Future<void> initializeCamera() async {
    // Mendapatkan daftar kamera
    _cameras = await availableCameras();
    _controller = CameraController(_cameras![0], ResolutionPreset.high);

    // Menginisialisasi controller kamera
    await _controller?.initialize();
  }

  // Fungsi untuk mengambil gambar
  Future<void> takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      print("Kamera belum diinisialisasi!");
      return;
    }

    try {
      // Mendapatkan direktori untuk menyimpan gambar
      final directory = await getApplicationDocumentsDirectory();
      final filePath = join(directory.path, '${DateTime.now()}.png');

      // Menyimpan gambar
      await _controller!.takePicture().then((XFile file) {
        file.saveTo(filePath);
        print("Gambar disimpan di: $filePath");
      });
    } catch (e) {
      print("Terjadi kesalahan saat mengambil gambar: $e");
    }
  }

  // Fungsi untuk membersihkan controller setelah selesai
  Future<void> dispose() async {
    await _controller?.dispose();
  }
}

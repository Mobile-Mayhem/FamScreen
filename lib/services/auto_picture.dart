import 'dart:async';
import 'package:flutter/material.dart';

class AutoPictureService with ChangeNotifier {
  Timer? _timer;

  void startAutoPicture(Function takePicture) {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(minutes: 5), (timer) {
      takePicture();
      print('Auto-take-picture running...');
    });
  }

  void stopAutoPicture() {
    _timer?.cancel();
    print('Auto-take-picture stopped.');
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

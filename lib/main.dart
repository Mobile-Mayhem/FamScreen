import 'package:camera/camera.dart';
import 'package:famscreen/pages/CameraPage.dart';
import 'package:famscreen/pages/OnBoardingPage.dart';
import 'package:flutter/material.dart';
import 'utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Mendapatkan kamera
  _cameras = await availableCameras();

  // Inisialisasi Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FamScreen',
      theme: customTheme,
      // home: OnBoardingPage(),
      home: OnBoardingPage(),
    );
  }
}

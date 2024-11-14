import 'package:camera/camera.dart';
import 'package:famscreen/pages/OnBoardingPage.dart';
import 'package:famscreen/pages/debug_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'utils/theme.dart';

late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      title: 'FamScreen',
      debugShowCheckedModeBanner: false,
      theme: customTheme,
      home: const OnBoardingPage(),
      // home: const DebugTest(),
      // home: Text("Test"),
    );
  }
}

import 'package:camera/camera.dart';
import 'package:famscreen/pages/OnBoardingPage.dart';
import 'package:famscreen/utils/Colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'pages/CameraPage.dart';
import 'services/video_services.dart';
import 'utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

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
    // const MyApp(),
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => VideoServices()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FamScreen',
      theme: customTheme,
      home: FutureBuilder(
        future: FirebaseAuth.instance.authStateChanges().first,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(CustomColor.primary),
              ),
            );
          } else if (snapshot.hasData) {
            return CameraPage();
          } else {
            return OnBoardingPage();
          }
        },
      ),
      // home: CameraPage(),
    );
  }
}

import 'package:famscreen/pages/MlTestPage.dart';
import 'package:famscreen/pages/OnBoardingPage.dart';
import 'package:flutter/material.dart';
import 'CameraPage.dart';
import 'LoginPage.dart';
import 'SearchScreen.dart';
import 'FavoritPage.dart';

class DebugTest extends StatefulWidget {
  const DebugTest({super.key});

  @override
  _DebugTest createState() => _DebugTest();
}

class _DebugTest extends State<DebugTest> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 70),

            // Button and Navigation Section
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () => MaterialPageRoute(
                        builder: (_) => const OnBoardingPage()),
                    child: const Text('Back to Introduction'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const CameraPage()),
                      );
                    },
                    child: const Text('Open Camera'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const LoginPage()),
                      );
                    },
                    child: const Text('Open Login Page'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const MlTestPage()),
                      );
                    },
                    child: const Text('Open ML'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => SearchScreen()),
                      );
                    },
                    child: const Text('Open Search Page'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => FavoritPage()),
                      );
                    },
                    child: const Text('Open Favorite Page'),
                  ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.of(context).push(
                  //       MaterialPageRoute(builder: (_) => TestApi()),
                  //     );
                  //   },
                  //   child: const Text('Open Try API Page'),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Uncomment if bottom navigation bar is needed
      // bottomNavigationBar: CustomNavigationBar(
      //   currentIndex: currentPageIndex,
      //   onDestinationSelected: (int index) {
      //     setState(() {
      //       currentPageIndex = index;
      //     });
      //   },
      // ),
    );
  }

  void _onBackToIntro(BuildContext context) {
    // Handle the back to intro action
  }
}

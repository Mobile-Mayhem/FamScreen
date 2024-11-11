import 'package:flutter/material.dart';
import 'package:projek/pages/CameraPage.dart';
import 'package:projek/pages/LoginPage.dart';
import 'package:projek/pages/DetailPage.dart';
import 'package:projek/pages/SearchScreen.dart';
import 'package:projek/pages/FavoritPage.dart';

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
                  const Text("This is the screen after Introduction"),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () => _onBackToIntro(context),
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
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.of(context).push(
                  //       MaterialPageRoute(builder: (_) => const DetailPage()),
                  //     );
                  //   },
                  //   child: const Text('Open Detail Page'),
                  // ),
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
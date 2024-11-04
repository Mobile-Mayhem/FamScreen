import 'package:flutter/material.dart';
import 'package:projek/pages/DetailPage.dart';
import 'package:projek/pages/FavoritPage.dart';
import 'package:projek/pages/LoginPage.dart';
import 'package:projek/pages/OnBoardingPage.dart';
import 'package:projek/pages/CameraPage.dart';
import 'package:projek/pages/SearchScreen.dart';
import 'package:projek/pages/FavoritePage.dart'; 

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _onBackToIntro(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const OnBoardingPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
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
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const DetailPage()),
                );
              },
              child: const Text('Open Detail Page'),
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
                  MaterialPageRoute(builder: (_) => FavoriteScreen()), 
                );
              },
              child: const Text('Open Favorite Page'),
            ),
          ],
        ),
      ),
    );
  }
}

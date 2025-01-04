import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import '../pages/RegisterPage.dart';
import '../utils/Colors.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();
  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => RegisterPage()),
    );
  }

  Widget _buildImage(String assetName,
      [double width = 350, double height = 300]) {
    return Image.asset('assets/$assetName', width: width, height: height);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 15.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      autoScrollDuration: 3000,
      // infiniteAutoScroll: true,
      globalHeader: const Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 16, right: 16),
          ),
        ),
      ),
      pages: [
        PageViewModel(
          title: "Selamat Datang di FamScreen!",
          body:
              "Temukan film yang aman dan sesuai usia dengan deteksi wajah otomatis.",
          image: _buildImage('img.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Deteksi Usia Real-Time",
          body:
              "Kami mendeteksi usia Anda secara real-time untuk menyesuaikan konten yang ditampilkan.",
          image: _buildImage('img1.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Rekomendasi Film Personal",
          body: "Nikmati film yang direkomendasikan khusus untuk usia Anda.",
          image: _buildImage('img2.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Keamanan untuk Keluarga",
          body:
              "Cegah anak-anak dari konten dewasa dengan peringatan otomatis.",
          image: _buildImage('img3.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Mulai Sekarang",
          body: "Daftar dan nikmati rekomendasi film sesuai usia Anda!",
          image: _buildImage('img4.jpg'),
          footer: Center(
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed('/register');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColor.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 130.0, vertical: 10.0),
              ),
              child: const Text(
                'Daftar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          decoration: pageDecoration.copyWith(
            bodyFlex: 6,
            imageFlex: 6,
            safeArea: 80,
          ),
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      back: const Icon(Icons.arrow_back, color: CustomColor.primary),
      next: const Icon(
        Icons.arrow_forward,
        color: CustomColor.primary,
      ),
      done: const Text('Done',
          style: TextStyle(
              fontWeight: FontWeight.w600, color: CustomColor.primary)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}

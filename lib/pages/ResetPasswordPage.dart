import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/EmailForm.dart';
import '../controllers/AuthController.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final authController = Get.put(AuthController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Image.asset('assets/logo.png', height: 120),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                'Lupa Password',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text('Masukkan email yang terdaftar'),
            ),
            EmailForm(emailController: emailController),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                await authController.resetPassword(
                    email: emailController.text, context: context);
              },
              child: const Text('Kirim'),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

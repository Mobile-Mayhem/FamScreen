import 'package:famscreen/components/OtherMethod.dart';
import 'package:famscreen/components/PasswordForm.dart';

import 'package:famscreen/routes/AppRoutes.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/EmailForm.dart';
import '../controllers/AuthController.dart';
import '../utils/Colors.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Image.asset('assets/logo.png', height: 120),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                'Masuk',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('Masukkan email dan password anda'),
            ),
            EmailForm(emailController: emailController),
            SizedBox(height: 15),
            PasswordForm(passwordController: passwordController),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.resetpw);
                  },
                  child: const Text('Lupa Password?'),
                ),
              ],
            ),
            const SizedBox(height: 25.0),
            ElevatedButton(
              onPressed: () async {
                await authController.signin(
                  email: emailController.text,
                  password: passwordController.text,
                  context: context,
                );

                print('Loginn');
              },
              child: const Text('Login'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text('Atau'),
            SizedBox(
              height: 25,
            ),
            OtherMethod(),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Belum punya akun?'),
                TextButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.register);
                    print('Daftar');
                  },
                  child: const Text('Daftar',
                      style: TextStyle(color: CustomColor.primary)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

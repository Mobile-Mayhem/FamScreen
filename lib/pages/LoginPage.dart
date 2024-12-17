import 'package:famscreen/components/OtherMethod.dart';
import 'package:famscreen/components/PasswordForm.dart';
import 'package:famscreen/services/auth_service.dart';
import 'package:flutter/material.dart';
import '../components/EmailForm.dart';
import 'RegisterPage.dart';
import '../utils/Colors.dart';

import 'ResetPasswordPage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void _showButtonPressDialog(BuildContext context, String provider) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$provider Button Pressed!'),
        backgroundColor: Colors.black26,
        duration: const Duration(milliseconds: 400),
      ),
    );
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => ResetPasswordPage()),
                    );
                  },
                  child: const Text('Lupa Password?'),
                ),
              ],
            ),
            const SizedBox(height: 25.0),
            ElevatedButton(
              onPressed: () async {
                await AuthService().signin(
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
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => RegisterPage()),
                    );
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

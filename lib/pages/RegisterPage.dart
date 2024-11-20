// import 'package:famscreen/services/auth_service.dart';
import 'package:famscreen/pages/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'LoginPage.dart';
import '../utils/Colors.dart';
import 'package:sign_button/sign_button.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

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

  Future<void> signup({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      // Call the Firebase signup function
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      // Handle errors
      String message = '';
      if (e.code == 'weak-password') {
        message = 'Password terlalu lemah';
      } else if (e.code == 'email-already-in-use') {
        message = 'Email sudah digunakan';
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      print('Error signing up: $e');
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                'Daftar',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text('Gunakan informasi yang sesuai'),
            ),
            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
                prefixIcon:
                    Icon(Icons.person_2_outlined, color: CustomColor.gray),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: CustomColor.primary),
                    borderRadius: BorderRadius.circular(10.0)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: CustomColor.primary, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0)),
                labelText: 'Nama Lengkap',
                labelStyle: TextStyle(color: CustomColor.gray),
                border: const OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email_outlined, color: CustomColor.gray),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: CustomColor.primary),
                    borderRadius: BorderRadius.circular(10.0)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: CustomColor.primary, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0)),
                labelText: 'Email',
                labelStyle: TextStyle(color: CustomColor.gray),
                border: const OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_outline, color: CustomColor.gray),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: CustomColor.primary),
                    borderRadius: BorderRadius.circular(10.0)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: CustomColor.primary, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0)),
                labelText: 'Password',
                labelStyle: TextStyle(color: CustomColor.gray),
                border: const OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Dengan mendaftar, Anda menyetujui Ketentuan dan Kebijakan Privasi',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                signup(
                  email: emailController.text,
                  password: passwordController.text,
                  context: context,
                );
                // Navigator.of(context).push(
                //   MaterialPageRoute(builder: (_) => const CameraPage()),
                // );
                print('Daftar');
              },
              child: const Text('Daftar'),
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
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SignInButton.mini(
                  buttonSize: ButtonSize.medium,
                  buttonType: ButtonType.google,
                  onPressed: () {
                    _showButtonPressDialog(context, 'Google');
                  },
                ),
                SignInButton.mini(
                  buttonType: ButtonType.facebook,
                  buttonSize: ButtonSize.medium,
                  onPressed: () {
                    _showButtonPressDialog(context, 'Google');
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Sudah Punya akun?'),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => LoginPage()),
                    );
                    print('Masuk');
                  },
                  child: const Text('Masuk',
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

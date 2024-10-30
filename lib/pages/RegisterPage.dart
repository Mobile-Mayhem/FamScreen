import 'package:flutter/material.dart';
import 'package:projek/pages/LoginPage.dart';
import 'package:projek/utils/Colors.dart';
import 'package:sign_button/sign_button.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  void _showButtonPressDialog(BuildContext context, String provider) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$provider Button Pressed!'),
        backgroundColor: Colors.black26,
        duration: const Duration(milliseconds: 400),
      ),
    );
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
                prefixIcon: Icon(Icons.person, color: CustomColor.primary),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: CustomColor.primary),
                    borderRadius: BorderRadius.circular(10.0)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: CustomColor.primary, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0)),
                labelText: 'Nama Lengkap',
                border: const OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email, color: CustomColor.primary),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: CustomColor.primary),
                    borderRadius: BorderRadius.circular(10.0)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: CustomColor.primary, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0)),
                labelText: 'Email',
                border: const OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.password, color: CustomColor.primary),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: CustomColor.primary),
                    borderRadius: BorderRadius.circular(10.0)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: CustomColor.primary, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0)),
                labelText: 'Password',
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
              onPressed: () {
                print('Loginn');
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
                      MaterialPageRoute(builder: (_) => const LoginPage()),
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

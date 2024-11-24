// import 'package:famscreen/services/auth_service.dart';
import 'package:famscreen/services/auth_service.dart';
import 'package:flutter/material.dart';
import '../components/EmailForm.dart';
import '../components/PasswordForm.dart';
import 'LoginPage.dart';
import '../utils/Colors.dart';
import 'package:sign_button/sign_button.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text('Gunakan informasi yang sesuai'),
                ),
                SizedBox(height: 15),
                EmailForm(emailController: emailController),
                SizedBox(height: 15),
                PasswordForm(passwordController: passwordController),
                SizedBox(height: 15),
                Text(
                  'Dengan mendaftar, Anda menyetujui Ketentuan dan Kebijakan Privasi',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    await AuthService().signup(
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
                      onPressed: () {},
                    ),
                    SignInButton.mini(
                      buttonType: ButtonType.facebook,
                      buttonSize: ButtonSize.medium,
                      onPressed: () {},
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
            )));
  }
}

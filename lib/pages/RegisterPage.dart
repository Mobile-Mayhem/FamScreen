import 'package:famscreen/components/NameForm.dart';
import 'package:famscreen/components/OtherMethod.dart';
import 'package:famscreen/routes/AppRoutes.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/EmailForm.dart';
import '../components/PasswordForm.dart';

import '../controllers/AuthController.dart';
import '../utils/Colors.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final authController = Get.put(AuthController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Padding(
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
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 24.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text('Gunakan informasi yang sesuai'),
                  ),
                  // NameForm(nameController: nameController),
                  NameForm(nameController: nameController),
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
                      await authController.signup(
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        context: context,
                      );
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
                  OtherMethod(),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Sudah Punya akun?'),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.login);
                          print('Masuk');
                        },
                        child: const Text('Masuk',
                            style: TextStyle(color: CustomColor.primary)),
                      )
                    ],
                  )
                ],
              )),
        ));
  }
}

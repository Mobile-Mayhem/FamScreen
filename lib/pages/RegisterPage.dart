import 'dart:io';
import 'package:famscreen/components/NameForm.dart';
import 'package:famscreen/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../components/EmailForm.dart';
import '../components/PasswordForm.dart';
import 'LoginPage.dart';
import '../utils/Colors.dart';
import 'package:sign_button/sign_button.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

 File? _profileImage;

  Future<void> _pickImage() async {
  final ImagePicker picker = ImagePicker();

  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(18.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 5.5,
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () async {
                    Navigator.of(context).pop();
                    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      setState(() {
                        _profileImage = File(image.path);
                      });
                    }
                  },
                  child: const SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image,
                          size: 50,
                        ),
                        Text("Galeri"),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () async {
                    Navigator.of(context).pop();
                    final XFile? image = await picker.pickImage(source: ImageSource.camera);
                    if (image != null) {
                      setState(() {
                        _profileImage = File(image.path);
                      });
                    }
                  },
                  child: const SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt,
                          size: 45,
                        ),
                        Text("Kamera"),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.grey[300],
                              backgroundImage:
                                  _profileImage != null ? FileImage(_profileImage!) : null,
                              child: _profileImage == null
                                  ? Icon(
                                      Icons.person,
                                      size: 60,
                                      color: Colors.grey[600],
                                    )
                                  : null,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: _pickImage,
                                child: CircleAvatar(
                                  radius: 18,
                                  backgroundColor: CustomColor.primary,
                                  child: Icon(
                                    Icons.add,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
                      await AuthService().signup(
                        name: nameController.text,
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
                          buttonType: ButtonType.mail,
                          buttonSize: ButtonSize.medium,
                          onPressed: () {
                            print('Login anonim');
                            AuthService().anonymousSignin(context);
                          }),
                      SignInButton.mini(
                        buttonSize: ButtonSize.medium,
                        buttonType: ButtonType.google,
                        onPressed: () {
                          AuthService().signInWithGoogle();
                        },
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
              )),
        ));
  }
}
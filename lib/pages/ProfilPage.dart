import 'package:famscreen/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int currentPageIndex = 4;
  final AuthService _authService = AuthService();

  Future<void> _showLogoutConfirmation() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Logout'),
          content: const Text('Apakah Anda yakin ingin keluar?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Tidak'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _authService.signout(context);
                Fluttertoast.showToast(
                  msg: 'Anda telah keluar',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              },
              child: const Text('Ya'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Profil',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset('assets/images/profil.png', height: 220)),
            const SizedBox(height: 35),
            const Text('Nama', style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
                color: Colors.transparent,
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                FirebaseAuth.instance.currentUser?.displayName ?? 'Belum diisi',
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.black54),
              ),
            ),
            const SizedBox(height: 15),
            const Text('Email', style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
                color: Colors.transparent,
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                FirebaseAuth.instance.currentUser!.email!.toString(),
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.black54),
              ),
            ),
            const SizedBox(height: 15),
            const Text('Password',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
                color: Colors.transparent,
              ),
              alignment: Alignment.centerLeft,
              child: const Text(
                '*******',
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.black54),
              ),
            ),
            const SizedBox(height: 45),
            // InkWell(
            //   onTap: () {
            //     // Navigator.push(
            //     //   context,
            //     //   MaterialPageRoute(builder: (_) => const EditProfilePage()),
            //     // );
            //   },
            //   child: Container(
            //     padding:
            //         const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(12),
            //       color: CustomColor.primary,
            //     ),
            //     alignment: Alignment.center,
            //     child: const Text(
            //       'Edit Profil',
            //       textAlign: TextAlign.left,
            //       style: TextStyle(
            //           color: Colors.black, fontWeight: FontWeight.bold),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 20),
            Center(
              child: InkWell(
                onTap: () {
                  _showLogoutConfirmation();
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

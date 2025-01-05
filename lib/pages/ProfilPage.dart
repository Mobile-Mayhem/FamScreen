import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/logoutConfirmationDialog.dart';
import '../controllers/ProfileController.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Profil',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset('assets/logo.png', height: 150)),
            const SizedBox(height: 35),
            const Text('Nama', style: TextStyle(fontWeight: FontWeight.bold)),
            Obx(() => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.transparent,
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    controller.userName.value,
                    style: const TextStyle(color: Colors.black54),
                  ),
                )),
            const SizedBox(height: 15),
            const Text('Email', style: TextStyle(fontWeight: FontWeight.bold)),
            Obx(() => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.transparent,
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    controller.userEmail.value,
                    style: const TextStyle(color: Colors.black54),
                  ),
                )),
            const SizedBox(height: 45),
            Center(
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return LogoutConfirmationDialog(
                        onConfirm: controller.logout,
                      );
                    },
                  );
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogoutConfirmationDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const LogoutConfirmationDialog({Key? key, required this.onConfirm})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Konfirmasi Logout'),
      content: const Text('Apakah Anda yakin ingin keluar?'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Tidak'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          child: const Text('Ya'),
        ),
      ],
    );
  }
}

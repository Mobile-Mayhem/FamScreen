import 'package:flutter/material.dart';

import '../utils/Colors.dart';

class PasswordForm extends StatelessWidget {
  const PasswordForm({
    super.key,
    required this.passwordController,
  });

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: passwordController,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock_outline, color: CustomColor.gray),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: CustomColor.primary),
            borderRadius: BorderRadius.circular(10.0)),
        focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: CustomColor.primary, width: 2.0),
            borderRadius: BorderRadius.circular(10.0)),
        labelText: 'Password',
        labelStyle: TextStyle(color: CustomColor.gray),
        border: const OutlineInputBorder(),
      ),
    );
  }
}

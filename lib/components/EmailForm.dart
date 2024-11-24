import 'package:flutter/material.dart';

import '../utils/Colors.dart';

class EmailForm extends StatelessWidget {
  const EmailForm({
    super.key,
    required this.emailController,
  });

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: emailController,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email_outlined, color: CustomColor.gray),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: CustomColor.primary),
            borderRadius: BorderRadius.circular(10.0)),
        focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: CustomColor.primary, width: 2.0),
            borderRadius: BorderRadius.circular(10.0)),
        labelText: 'Email',
        labelStyle: TextStyle(color: CustomColor.gray),
        border: const OutlineInputBorder(),
      ),
    );
  }
}

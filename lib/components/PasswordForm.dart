import 'package:flutter/material.dart';

import '../utils/Colors.dart';

class PasswordForm extends StatefulWidget {
  const PasswordForm({
    super.key,
    required this.passwordController,
  });

  final TextEditingController passwordController;

  @override
  _PasswordFormState createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.passwordController,
      obscureText: _obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock_outline, color: CustomColor.gray),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: CustomColor.gray,
          ),
          onPressed: _togglePasswordVisibility,
        ),
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

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../utils/Colors.dart';

class NameForm extends StatelessWidget {
  const NameForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
        prefixIcon: Icon(Icons.person_2_outlined, color: CustomColor.gray),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: CustomColor.primary),
            borderRadius: BorderRadius.circular(10.0)),
        focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: CustomColor.primary, width: 2.0),
            borderRadius: BorderRadius.circular(10.0)),
        labelText: 'Nama Lengkap',
        labelStyle: TextStyle(color: CustomColor.gray),
        border: const OutlineInputBorder(),
      ),
    );
  }
}

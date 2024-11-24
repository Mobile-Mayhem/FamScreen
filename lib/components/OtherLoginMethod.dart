import 'package:flutter/material.dart';
import 'package:sign_button/sign_button.dart';

class OtherLoginMethod extends StatelessWidget {
  const OtherLoginMethod({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}

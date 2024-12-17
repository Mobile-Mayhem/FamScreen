import 'package:flutter/material.dart';
import 'package:sign_button/sign_button.dart';

import '../services/auth_service.dart';

class OtherMethod extends StatelessWidget {
  const OtherMethod({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 47,
          height: 47,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blueGrey,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(1, 7),
              ),
            ],
          ),
          child: IconButton(
            onPressed: () {
              AuthService().anonymousSignin(context);
            },
            icon: Icon(Icons.person, color: Colors.white),
          ),
        ),
        SignInButton.mini(
          buttonSize: ButtonSize.medium,
          buttonType: ButtonType.google,
          onPressed: () {
            AuthService().signInWithGoogle(context);
          },
        ),
      ],
    );
  }
}

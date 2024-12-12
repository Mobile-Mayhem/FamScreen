import 'package:flutter/widgets.dart';
import 'package:sign_button/sign_button.dart';

import '../services/auth_service.dart';

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
            buttonType: ButtonType.mail,
            buttonSize: ButtonSize.medium,
            onPressed: () {
              print('Login anonim');
              AuthService().anonymousSignin(context);
            }),
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

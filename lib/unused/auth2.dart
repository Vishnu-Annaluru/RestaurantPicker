/*
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:restaurantpickerandroid/loginpage.dart';

import 'registerpage.dart';

class Auth2 extends StatefulWidget {
  const Auth2({Key? key}) : super(key: key);

  @override
  State<Auth2> createState() => _Auth2State();
}

class _Auth2State extends State<Auth2> {
  bool launchLogin = true;

  void toggleScreens() {
    setState(() {
      launchLogin = !launchLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (launchLogin) {
      return LoginPage(launchRegister: toggleScreens);
    } else {
      return RegisterPage(launchLogin: toggleScreens);
    }
  }
}
*/

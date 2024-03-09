import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
//import 'package:firebase_auth/firebase_auth.dart';

/*

  idk what to put in the settings bruh


*/

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  //final user = FirebaseAuth.instance.currentUser!;
  bool clicked = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            ("Hello"),
          ),
          MaterialButton(
            onPressed: () {
              //FirebaseAuth.instance.signOut();
            },
            child: const Text("Sign Out"),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                clicked = !clicked;
              });
            },
            icon: Icon(
              (clicked == false) ? Icons.favorite : Icons.business_outlined,
              size: 60,
            ),
          ),
        ],
      ),
    );
  }
}

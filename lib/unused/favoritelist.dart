import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteList extends StatefulWidget {
  const FavoriteList({Key? key}) : super(key: key);

  @override
  State<FavoriteList> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  late TextEditingController c1;
  late TextEditingController c2;
  late TextEditingController c3;
  late TextEditingController c4;
  late TextEditingController c5;

  String f1 = "";
  String f2 = "";
  String f3 = "";
  String f4 = "";
  String f5 = "";

  

  @override
  void initState() {
    super.initState();
    c1 = TextEditingController();
    c2 = TextEditingController();
    c3 = TextEditingController();
    c4 = TextEditingController();
    c5 = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    c1.dispose();
    c2.dispose();
    c3.dispose();
    c4.dispose();
    c5.dispose();
  }

  void save() {
    List favorites = [
      //widget.day,
      c1.text,
      c2.text,
      c3.text,
      c4.text,
      c5.text,
    ];
    //widget.infoSaved(dailyMeals);
    Navigator.of(context).pop(favorites);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: "First Favorite",
                hintStyle: TextStyle(color: Colors.teal.shade300),
              ),
              controller: c1,
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: "Second Favorite",
                  hintStyle: TextStyle(color: Colors.teal.shade300)),
              controller: c2,
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: "Third Favorite",
                  hintStyle: TextStyle(color: Colors.teal.shade300)),
              controller: c3,
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: "Fourth Favorite",
                  hintStyle: TextStyle(color: Colors.teal.shade300)),
              controller: c4,
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: "Fifth Favorite",
                  hintStyle: TextStyle(color: Colors.teal.shade300)),
              controller: c5,
            ),
          ],
        ),
      ),
    );
  }
}

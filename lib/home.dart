import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'day.dart';
import 'schedule.dart';
import 'customlist.dart';
import 'week.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class Home extends StatefulWidget {
  final List hinfoSaved;

  const Home({Key? key, required this.hinfoSaved}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  //final user = FirebaseAuth.instance.currentUser!;

  String db = "";
  String dl = "";
  String dd = "";
  List homeList = [];
  int current = 0;

  List favorites = ["", "", "", "", ""];

  String random() {
    final rand = Random();
    String quickFav = favorites[rand.nextInt(favorites.length)];
    if (favorites[0] == "" &&
        favorites[1] == "" &&
        favorites[2] == "" &&
        favorites[3] == "" &&
        favorites[4] == "") {
      return "No Favorites";
    }
    if (quickFav == "") {
      return favorites[rand.nextInt(favorites.length)];
    }
    return quickFav;
  }
/*
  Future getFavorites() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user.email!)
        .collection("Custom")
        .doc("Favorites")
        .get()
        .then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;

        setState(
          () {
            print("FAV DATA: $data");
            favorites[0] = data["Fav1"];
            favorites[1] = data["Fav2"];
            favorites[2] = data["Fav3"];
            favorites[3] = data["Fav4"];
            favorites[4] = data["Fav5"];

            print("GET FAVORITES FAVORITES: $favorites");
          },
        );
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }
  */

  final List _days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    List info = widget.hinfoSaved;
    print("HOME LIST: $info");
  }

  @override
  void initState() {
    super.initState();
    //getFavorites();
    Schedule(
      sinfoSaved: ((List mainlist) {
        setState(() {
          print("HOME LISTTTT: $homeList");
          homeList = mainlist;
        });
      }),
    );
    _controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  bool quickclicked = false;
//      backgroundColor: const Color.fromARGB(255, 17, 17, 17),

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color.fromARGB(255, 17, 17, 17),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 70,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    _controller.forward();
                    Timer(
                      const Duration(milliseconds: 1500),
                      () {
                        _controller.reverse();
                        print(favorites);
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: Colors.teal[100],
                            title: Center(
                              child: Text(
                                random(),
                                style: GoogleFonts.robotoCondensed(
                                  color: Colors.teal[300],
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: Navigator.of(context).pop,
                                child: const Text("Ok"),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Lottie.network(
                        "https://assets7.lottiefiles.com/packages/lf20_wgvpi631.json",
                        width: 220,
                        height: 220,
                        fit: BoxFit.fill,
                        controller: _controller,
                      ),
                      Text(
                        "Quick Choice",
                        style: GoogleFonts.robotoCondensed(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: GestureDetector(
                        onTap: () {
                          print("Custom Lists pressed");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CustomList(
                                  sendFavorites: (List receivedFavorites) =>
                                      setState(() {
                                    favorites = receivedFavorites;
                                    print("HOME FAVORITES: $favorites");
                                  }),
                                  getFavorites: favorites,
                                ),
                              ));
                        },
                        child: Container(
                          height: 50,
                          width: 160,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 34, 34, 34),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              "Favorites",
                              style: GoogleFonts.robotoCondensed(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    const Center(
                      child: Text(
                        "This Week",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 1,
                      width: 350,
                      child: Container(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: SizedBox(
                        height: 1300,
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 7,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Week(
                              day: _days[index],
                              infoSaved: (List scheduleList) => setState(
                                (() {
                                  print("SCHEDULE LIST: $scheduleList");
                                  //widget.sinfoSaved(scheduleList);
                                }),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                    
                    
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

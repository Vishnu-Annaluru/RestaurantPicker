import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'locationservice.dart';
import 'userlocation.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:simple_url_preview/simple_url_preview.dart';

class Search extends StatefulWidget {
  Search({Key? key}) : super(key: key);

  final dio = Dio(
    BaseOptions(
      baseUrl: "https://api.yelp.com/v3/businesses/search",
      headers: {
        "Authorization":
            "Bearer iqDQGKyBgLW2z1YmuWIqKhBTDz-o9fWozT-tjiszM7yna1_1Lu3_tnx8lb484kIncVA4c2OLPkMM5jJtBx6Z_pBfW4Tvno7-2hstnzVEBwrdVT9UDMMf2gIy2mPxYnYx",
      },
    ),
  );

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late var rest;
  final _textController = TextEditingController();
  late SharedPreferences preferences;
  int x = 1;
  bool pressed = false;

  //Icon filled = Icons.favorite_outline_sharp as Icon;

  double latitude = 50;
  double longitude = 50;
  String c = "";

  final _formKey = GlobalKey<FormState>();
  //final user = FirebaseAuth.instance.currentUser!;

  List _restaurants = [];

  var _search;
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
/*
  Future addFavorites(String f) async {
    //getRestaurants();
    print("addfavoritessearch called");
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user.email)
        .collection("Restaurants")
        .doc("restaurants")
        .update(
      {
        "Restaurants": FieldValue.arrayUnion([f]),
      },
    );
  }


  Future getRestaurants() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user.email!)
        .collection("Restaurants")
        .doc("restaurants")
        .get()
        .then(
      (DocumentSnapshot doc) {
        final data = doc.data();

        setState(
          () {
            try {
              List temp = [];
              String d = data.toString();
              d = d.substring(15, (d.length - 2));
              print("REST DATAD: $d");
              for (int i = 0; i < d.split(", ").length; i++) {
                favorites.add(d.split(", ")[i]);
              }
            } on Exception catch (_) {
              print(_);
            }
            print("REST DATA: $data");

            //restaurants = data;
            //String r = data;
            //print(restaurants);
            print("REST DATAMOG: $favorites");
          },
        );
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }
  */

  @override
  void initState() {
    super.initState();
    init();
    //getRestaurants();
  }

  Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
    await preferences.reload();
  }

  void searchResturants(double lat, double long, String categorie) async {
    //String cat = "";
    //if (categorie != "") {
    ///  cat = categorie;
    // }
    final response = await widget.dio.get(
      "https://api.yelp.com/v3/businesses/search",
      queryParameters: {
        "latitude": lat,
        "longitude": long,
        "categories": "food",
        "term": categorie,
        "radius": 40000,
        "limit": 50,
        "sort-by": "review_count"
      },
    );

    setState(() {
      _restaurants = response.data["businesses"];
      print("RESTAURANTS: $_restaurants");
      if (response.data["businesses"] == null) {
        x = 0;
      }
      x = 1;
    });

    print("RESPONSE: $response");
    var results = response.toString().length;
    print("RESULTS: $results");
  }

  @override
  Widget build(BuildContext context) {
    var userLocation = Provider.of<UserLocation>(context);

    String cat1 = "";
    String cat2 = "";
    String cat3 = "";

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 17, 17, 17),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Search for Restaurants",
                        style: TextStyle(fontSize: 15),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 47, 47, 48),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: TextField(
                              controller: _textController,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: (() {
                          setState(
                            () {
                              if (_textController.text != "") {
                                c = _textController.text;
                              }
                              searchResturants(userLocation.latitude,
                                  userLocation.longitude, c);
                              c = "";
                            },
                          );
                        }),
                        child: Text(
                          "Search",
                          style: GoogleFonts.robotoCondensed(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      x == 0
                          ? const Text(
                              "No results",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 50),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 550,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ListView(
                                        physics: const BouncingScrollPhysics(),
                                        itemExtent: 70,
                                        padding: const EdgeInsets.all(8),
                                        children:
                                            _restaurants.map((restaurant) {
                                          return Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Container(
                                              height: 90,
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 47, 47, 48),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color:
                                                          Colors.grey.shade900,
                                                      spreadRadius: 0.5,
                                                      blurRadius: 1,
                                                    ),
                                                  ],
                                                ),
                                                child: ListTile(
                                                    onTap: () {
                                                      print("tile tapped");
                                                      try {
                                                        setState(() {
                                                          cat1 = restaurant[
                                                                  "categories"]
                                                              [0]["title"];
                                                          cat2 = restaurant[
                                                                  "categories"]
                                                              [1]["title"];
                                                          cat3 = restaurant[
                                                                  "categories"]
                                                              [2]["title"];
                                                        });
                                                      } catch (_) {
                                                        print(
                                                            "NO CATEGORIE MOGUS");
                                                      }
                                                      showModalBottomSheet(
                                                        isDismissible: true,
                                                        isScrollControlled:
                                                            true,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        shape:
                                                            const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .vertical(
                                                            top:
                                                                Radius.circular(
                                                                    25),
                                                          ),
                                                        ),
                                                        context: context,
                                                        builder: ((context) =>
                                                            buildSheet(
                                                              restaurant[
                                                                  "name"],
                                                              restaurant[
                                                                      "location"]
                                                                  [
                                                                  "display_address"][0],
                                                              "${toMiles(restaurant["distance"])} miles",
                                                              restaurant[
                                                                  "image_url"],
                                                              cat1,
                                                              cat2,
                                                              cat3,
                                                              restaurant[
                                                                  "is_closed"],
                                                              restaurant["url"],
                                                            )),
                                                      );
                                                    },
                                                    horizontalTitleGap: 10,
                                                    title: Text(
                                                      restaurant["name"],
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    subtitle: Text(
                                                      restaurant["location"][
                                                          "display_address"][0],
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    trailing: Text(
                                                      "${toMiles(restaurant["distance"])} miles",
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    leading: ClipRRect(
                                                      child: CircleAvatar(
                                                        backgroundImage: (restaurant[
                                                                    "image_url"]! ==
                                                                null)
                                                            ? const NetworkImage(
                                                                "https://cwdaust.com.au//wpress//wp-content//uploads//2015//04//placeholder-restaurant-300x300.png")
                                                            : NetworkImage(
                                                                restaurant[
                                                                    "image_url"]),
                                                      ),
                                                    ),

                                                    //tileColor: const Color.fromARGB(255, 47, 47, 48),
                                                    minVerticalPadding: 5),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String toMiles(double meters) {
    double miles;
    miles = meters / 1609;
    return miles.toStringAsFixed(2);
  }

  Widget buildSheet(String name, String address, String distance, String image,
      String c1, String c2, String c3, bool closed, String url) {
    String c11 = "";

    if (c3 == "") {
      c11 = "$c1 | ";
    }
    if (c2 == "") {
      c11 = c1;
    }
    if (c3 != "") {
      c11 = "$c1 | ";
      c2 = "$c2 | ";
    }

    String status = "";
    if (closed) {
      status = "Currently Closed";
    } else {
      status = "Currently Open";
    }
    try {
      if (preferences.getStringList("Favorites")!.contains(name)) {
        print("CONTAINS");
        pressed = false;
      } else {
        pressed = true;
      }
    } on Exception catch (_) {}

    return StatefulBuilder(
      builder: (context, setDState) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          maxChildSize: 0.8,
          builder: (_, controller) => Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              color: Colors.grey[800],
              /*
            image: DecorationImage(
              image: NetworkImage(
                image,
              ),
            ),
            */
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Center(
                  child: Text(
                    name,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Center(
                  child: Text(
                    "$address\n$distance",
                    style: TextStyle(color: Colors.grey[200]),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    image,
                    height: 200,
                    width: 200,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Center(
                    child: Text(
                      "$c11$c2$c3",
                      style: TextStyle(
                        color: Colors.grey[200],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 0,
                ),
                Center(
                  child: Text(
                    "Show closed if not here",
                    style: TextStyle(color: Colors.blueGrey[200]),
                  ),
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 100,
                    ),
                    IconButton(
                      onPressed: () {
                        print("$name favorited");
                        //showToast("\"$name\" added to favorites!");
                        setState(() {
                          setDState(() {
                            pressed = !pressed;
                            print("TYO $pressed");
                            if (pressed) {
                              print("TYO    $name    REMOVED");
                            }
                            if (!pressed) {
                              print("TYO    $name      ADDED");
                            }
                            try {
                              //preferences.reload();
                              List<String> favs = [];
                              if (!pressed) {
                                if (preferences.getStringList("Favorites") ==
                                    null) {
                                  favs.add(name);
                                  setFavorites(favs);
                                } else {
                                  favs =
                                      preferences.getStringList("Favorites")!;
                                  if (!favs.contains(name)) {
                                    favs.add(name);
                                    setFavorites(favs);
                                  }
                                }
                              } else {
                                print(
                                    "REMOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOVEED");
                                favs = preferences.getStringList("Favorites")!;
                                favs.remove(name);
                                setFavorites(favs);
                              }

                              print("TYO   $favs");
                            } on Exception catch (_) {
                              print(_);
                            }
                          });
                        });
                        //addFavorites(name);
                      },
                      icon: Icon(
                        (!pressed)
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    IconButton(
                      onPressed: () {
                        print("directions pressed");
                      },
                      icon: const Icon(
                        Icons.directions,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Center(
                  child: GestureDetector(
                    onTap: (() {
                      openURL(url);
                    }),
                    child: const Text(
                      "Placeholder yelp link",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showToast(String messsage) => Fluttertoast.showToast(
        msg: messsage,
        fontSize: 18,
      );

  Future<void> setFavorites(List<String> favs) async {
    await preferences.reload();

    await preferences.setStringList("Favorites", favs);
    List<String> mug = preferences.getStringList("Favorites")!;
    print("AMUGUG: $mug");
  }

  openURL(url) async {
    final Uri uri = Uri.parse(url);

    await launchUrl(uri);
  }

  getImage(String url) {
    NetworkImage(
        "https://cwdaust.com.au/wpress/wp-content/uploads/2015/04/placeholder-restaurant-300x300.png");
  }
}

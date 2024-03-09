import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomList extends StatefulWidget {
  final Function(List) sendFavorites;
  final List getFavorites;

  CustomList(
      {Key? key, required this.sendFavorites, required this.getFavorites})
      : super(key: key);

  @override
  State<CustomList> createState() => _CustomListState();
}

class _CustomListState extends State<CustomList> {
  //final user = FirebaseAuth.instance.currentUser!;
  late SharedPreferences preferences;
  late TextEditingController c1;
  late TextEditingController c2;
  late TextEditingController c3;
  late TextEditingController c4;
  late TextEditingController c5;

  List<String> restaurants = [];

  String f1 = "";
  String f2 = "";
  String f3 = "";
  String f4 = "";
  String f5 = "";
  String among = "sus";

  getFavorites() async {
    preferences = await SharedPreferences.getInstance();

    setState(
      () {
        c1.text = preferences.getStringList("Custom")![0];
        c2.text = preferences.getStringList("Custom")![1];
        c3.text = preferences.getStringList("Custom")![2];
        c4.text = preferences.getStringList("Custom")![3];
        c5.text = preferences.getStringList("Custom")![4];
      },
    );
  }
/*

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
              String d = data.toString();
              d = d.substring(15, (d.length - 2));
              print("REST DATAD: $d");
              for (int i = 0; i < d.split(", ").length; i++) {
                restaurants.add(d.split(", ")[i]);
              }
            } on Exception catch (_) {
              print(_);
            }
            print("REST DATA: $data");

            //restaurants = data;
            //String r = data;
            //print(restaurants);
            print("REST DATAMOG: $restaurants");
          },
        );
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }
*/

  Future<void> getRestaurants() async {
    try {
      // await preferences.reload();
      preferences = await SharedPreferences.getInstance();

      setState(() {
        restaurants = preferences.getStringList("Favorites")!;
      });
      among = restaurants[0];
      print("AMUGUG: $restaurants");
    } on Exception catch (_) {}
  }

  void addFavorites(List<String> list) {
    preferences.setStringList("Custom", list);
  }
/*
  Future removeFavorite(String name) async {
    print("$name DELETED");
    setState(() async {
      final updates = <String, dynamic>{
        "Restaurants": FieldValue.arrayRemove([name]),
      };
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.email!)
          .collection("Restaurants")
          .doc("restaurants")
          .update(updates);
    });
  }
  */

  @override
  void initState() {
    super.initState();
    init();
    getRestaurants();
    getFavorites();

    c1 = TextEditingController();
    c2 = TextEditingController();
    c3 = TextEditingController();
    c4 = TextEditingController();
    c5 = TextEditingController();
  }

  Future init() async {
    preferences = await SharedPreferences.getInstance();
    preferences.reload();
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
    List<String> favorites = [
      //widget.day,
      c1.text,
      c2.text,
      c3.text,
      c4.text,
      c5.text,
    ];
    addFavorites(favorites);
    widget.sendFavorites(favorites);
    Navigator.of(context).pop(favorites);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "Favorites",
          style: TextStyle(
            color: Colors.teal[700],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 17, 17, 17),
        leading: IconButton(
          onPressed: () {
            print("Back pressed");
            save();
            if (widget.getFavorites == null || widget.getFavorites.isEmpty)
              return;
            setState(
              () {
                c1.text = widget.getFavorites[0];
                c2.text = widget.getFavorites[1];
                c3.text = widget.getFavorites[2];
                c4.text = widget.getFavorites[3];
                c5.text = widget.getFavorites[4];
                List sus = widget.getFavorites;
                print("CUSTOM LIST GET FAVPROTES: $sus");
              },
            );
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 17, 17, 17),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Custom Favorites",
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 47, 47, 48),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      style: TextStyle(
                        color: Colors.teal.shade100,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "First Favorite",
                        contentPadding: const EdgeInsets.all(10),
                        hintStyle: GoogleFonts.robotoCondensed(
                            color: Colors.teal.shade300),
                      ),
                      controller: c1,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 47, 47, 48),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      style: TextStyle(
                        color: Colors.teal.shade100,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Second Favorite",
                        contentPadding: const EdgeInsets.all(10),
                        hintStyle: GoogleFonts.robotoCondensed(
                            color: Colors.teal.shade300),
                      ),
                      controller: c2,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 47, 47, 48),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      style: TextStyle(
                        color: Colors.teal.shade100,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Third Favorite",
                        contentPadding: const EdgeInsets.all(10),
                        hintStyle: GoogleFonts.robotoCondensed(
                            color: Colors.teal.shade300),
                      ),
                      controller: c3,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 47, 47, 48),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      style: TextStyle(
                        color: Colors.teal.shade100,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Fourth Favorite",
                        contentPadding: const EdgeInsets.all(10),
                        hintStyle: GoogleFonts.robotoCondensed(
                            color: Colors.teal.shade300),
                      ),
                      controller: c4,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 47, 47, 48),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      style: TextStyle(
                        color: Colors.teal.shade100,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Fifth Favorite",
                        contentPadding: const EdgeInsets.all(10),
                        hintStyle: GoogleFonts.robotoCondensed(
                            color: Colors.teal.shade300),
                      ),
                      controller: c5,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Selected Favorites",
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: SizedBox(
                    height: restaurants.length * 75,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: restaurants.length,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 47, 47, 48),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ListTile(
                              title: Text(
                                restaurants[index],
                                style: TextStyle(color: Colors.teal.shade300),
                              ),
                              trailing: IconButton(
                                onPressed: (() {
                                  setState(() {
                                    restaurants.removeAt(index);
                                  });
                                  removeRestaurant();

                                  //removeFavorite(restaurants[index + 1]);
                                }),
                                icon: const Icon(Icons.close),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> removeRestaurant() async {
    await preferences.setStringList("Favorites", restaurants);
  }
}

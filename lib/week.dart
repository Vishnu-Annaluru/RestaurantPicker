import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Week extends StatefulWidget {
  final String day;
  final Function(List) infoSaved;

  const Week({Key? key, required this.day, required this.infoSaved})
      : super(key: key);

  @override
  State<Week> createState() => _WeekState();
}

class _WeekState extends State<Week> {
  //final user = FirebaseAuth.instance.currentUser!;
  late SharedPreferences preferences;
  late TextEditingController breakfast;
  late TextEditingController lunch;
  late TextEditingController dinner;

  late List all = [
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    ""
  ];

  List mon = ["", "", ""];
  List tue = ["", "", ""];
  List wed = ["", "", ""];
  List thur = ["", "", ""];
  List fri = ["", "", ""];
  List sat = ["", "", ""];
  List sun = ["", "", ""];

  String db = "";
  String dl = "";
  String dd = "";

  void getMonday() {
    try {
      String? m = preferences.getString("Monday");
      List temp = m!.split(" ");
      setState(() {
        tue[0] = temp[0];
        tue[1] = temp[1];
        tue[2] = temp[2];

        db = temp[0];
        dl = temp[1];
        dd = temp[2];

        breakfast.text = temp[0];
        lunch.text = temp[1];
        dinner.text = temp[2];
      });
    } on Exception catch (_) {}
  }

  void getTuesday() {
    try {
      String? m = preferences.getString("Tuesday");
      List temp = m!.split(" ");
      setState(() {
        tue[0] = temp[0];
        tue[1] = temp[1];
        tue[2] = temp[2];

        db = temp[0];
        dl = temp[1];
        dd = temp[2];

        breakfast.text = temp[0];
        lunch.text = temp[1];
        dinner.text = temp[2];
      });
    } on Exception catch (_) {}
  }

  void getWednesday() {
    try {
      String? m = preferences.getString("Wednesday");
      List temp = m!.split(" ");
      setState(() {
        tue[0] = temp[0];
        tue[1] = temp[1];
        tue[2] = temp[2];

        db = temp[0];
        dl = temp[1];
        dd = temp[2];

        breakfast.text = temp[0];
        lunch.text = temp[1];
        dinner.text = temp[2];
      });
    } on Exception catch (_) {}
  }

  void getThursday() {
    try {
      String? m = preferences.getString("Thursday");
      List temp = m!.split(" ");
      setState(() {
        tue[0] = temp[0];
        tue[1] = temp[1];
        tue[2] = temp[2];

        db = temp[0];
        dl = temp[1];
        dd = temp[2];

        breakfast.text = temp[0];
        lunch.text = temp[1];
        dinner.text = temp[2];
      });
    } on Exception catch (_) {}
  }

  void getFriday() {
    try {
      String? m = preferences.getString("Friday");
      List temp = m!.split(" ");
      setState(() {
        tue[0] = temp[0];
        tue[1] = temp[1];
        tue[2] = temp[2];

        db = temp[0];
        dl = temp[1];
        dd = temp[2];

        breakfast.text = temp[0];
        lunch.text = temp[1];
        dinner.text = temp[2];
      });
    } on Exception catch (_) {}
  }

  void getSaturday() {
    try {
      String? m = preferences.getString("Saturday");
      List temp = m!.split(" ");
      setState(() {
        tue[0] = temp[0];
        tue[1] = temp[1];
        tue[2] = temp[2];

        db = temp[0];
        dl = temp[1];
        dd = temp[2];

        breakfast.text = temp[0];
        lunch.text = temp[1];
        dinner.text = temp[2];
      });
    } on Exception catch (_) {}
  }

  void getSunday() {
    try {
      String? m = preferences.getString("Sunday");
      List temp = m!.split(" ");
      setState(() {
        tue[0] = temp[0];
        tue[1] = temp[1];
        tue[2] = temp[2];

        db = temp[0];
        dl = temp[1];
        dd = temp[2];

        breakfast.text = temp[0];
        lunch.text = temp[1];
        dinner.text = temp[2];
      });
    } on Exception catch (_) {}
  }

  
  @override
  initState() {
    super.initState();

    init();

    

    breakfast = TextEditingController();
    lunch = TextEditingController();
    dinner = TextEditingController();
  }

  Future init() async {
    preferences = await SharedPreferences.getInstance();

    if (widget.day == "Monday") {
      getMonday();
    }
    if (widget.day == "Tuesday") {
      getTuesday();
    }
    if (widget.day == "Wednesday") {
      getWednesday();
    }
    if (widget.day == "Thursday") {
      getThursday();
    }
    if (widget.day == "Friday") {
      getFriday();
    }
    if (widget.day == "Saturday") {
      getSaturday();
    }
    if (widget.day == "Sunday") {
      getSunday();
    }
  }

  void saveSchedule(List list) {
    preferences.setString(widget.day, list[1] + " " + list[2] + " " + list[3]);
  }

  @override
  void dispose() {
    super.dispose();
    breakfast.dispose();
    lunch.dispose();
    dinner.dispose();
  }

/*
  Future addSchedule(List list) async {
    print("addschedule called");
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user.email)
        .collection("Schedule")
        .doc(widget.day)
        .set(
      {
        "Day": widget.day,
        "Breakfast": list[1],
        "Lunch": list[2],
        "Dinner": list[3],
      },
    );
  }
  */

  void save() {
    List dailyMeals = [
      widget.day,
      breakfast.text,
      lunch.text,
      dinner.text,
    ];
    saveSchedule(dailyMeals);
    widget.infoSaved(dailyMeals);
    Navigator.of(context).pop(dailyMeals);
  }

  Future<List?> openDialog() => showDialog<List>(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.teal[100],
          title: Text(
            widget.day,
            style: GoogleFonts.robotoCondensed(
              color: Colors.black,
              fontStyle: FontStyle.italic,
            ),
          ),
          content: Column(
            children: [
              TextField(
                autofocus: true,
                maxLength: 20,
                decoration: InputDecoration(
                  hintText: "Breakfast",
                  hintStyle: TextStyle(color: Colors.teal.shade300),
                ),
                controller: breakfast,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: "Lunch",
                    hintStyle: TextStyle(color: Colors.teal.shade300)),
                controller: lunch,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: "Dinner",
                    hintStyle: TextStyle(color: Colors.teal.shade300)),
                controller: dinner,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                save();
              },
              child: Text(
                "Save",
                style: TextStyle(color: Colors.teal[300]),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 34, 34, 34),
          borderRadius: BorderRadius.circular(15),
        ),
        height: 145,
        width: 170,
        child: Column(
          children: [
            Text(
              widget.day,
              style: GoogleFonts.robotoCondensed(
                  color: Colors.white, fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  height: 1,
                  width: 500,
                  child: Container(color: Color.fromARGB(255, 66, 66, 66)),
                ),
              ),
            ),
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 7.0, left: 5.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: [
                              TextSpan(
                                text: "Breakfast: ",
                                style: GoogleFonts.robotoCondensed(
                                    fontSize: 20, color: Colors.white),
                              ),
                              TextSpan(
                                text: db,
                                style: GoogleFonts.robotoCondensed(
                                    fontSize: 17, color: Colors.teal[200]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 5),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          height: 1,
                          width: 250,
                          child: Container(color: Color.fromARGB(255, 66, 66, 66)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: [
                              TextSpan(
                                text: "Lunch: ",
                                style: GoogleFonts.robotoCondensed(
                                    fontSize: 20, color: Colors.white),
                              ),
                              TextSpan(
                                text: dl,
                                style: GoogleFonts.robotoCondensed(
                                    fontSize: 17, color: Colors.teal[200]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 5),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          height: 1,
                          width: 250,
                          child: Container(color: Color.fromARGB(255, 66, 66, 66)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: [
                              TextSpan(
                                text: "Dinner: ",
                                style: GoogleFonts.robotoCondensed(
                                    fontSize: 20, color: Colors.white),
                              ),
                              TextSpan(
                                text: dd,
                                style: GoogleFonts.robotoCondensed(
                                    fontSize: 17, color: Colors.teal[200]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 5),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          height: 1,
                          width: 250,
                          child: Container(color: Color.fromARGB(255, 66, 66, 66)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 18,
                ),
                FloatingActionButton(
                  heroTag: "b${widget.day}",
                  onPressed: () async {
                    print("Day clicked: ${widget.day}");
                    final List? list = await openDialog();
                    if (list == null || list.isEmpty) return;
                    setState(
                      () {
                        db = list[1];
                        dl = list[2];
                        dd = list[3];

                        if (widget.day == "Monday") {
                          all[0] = db;
                          all[1] = dl;
                          all[2] = dd;
                        }
                        if (widget.day == "Tuesday") {
                          all[3] = db;
                          all[4] = dl;
                          all[5] = dd;
                        }
                        if (widget.day == "Wednesday") {
                          all[6] = db;
                          all[7] = dl;
                          all[8] = dd;
                        }
                        if (widget.day == "Thursday") {
                          all[9] = db;
                          all[10] = dl;
                          all[11] = dd;
                        }
                        if (widget.day == "Friday") {
                          all[12] = db;
                          all[13] = dl;
                          all[14] = dd;
                        }
                        if (widget.day == "Saturday") {
                          all[15] = db;
                          all[16] = dl;
                          all[17] = dd;
                        }
                        if (widget.day == "Sunday") {
                          all[18] = db;
                          all[19] = dl;
                          all[20] = dd;
                        }

                        print("ALL: $all");
                      },
                    );
                  },
                  backgroundColor: Color.fromARGB(255, 56, 56, 56),
                  child: const Icon(Icons.edit),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/*
Column(
          children: [
            Text(
              widget.day,
              style: GoogleFonts.robotoCondensed(
                  color: Colors.white, fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  height: 1,
                  width: 500,
                  child: Container(color: Colors.teal[700]),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 7.0, left: 5.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Breakfast: ",
                  style: GoogleFonts.robotoCondensed(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  height: 1,
                  width: 250,
                  child: Container(color: Colors.teal[700]),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Lunch: ",
                  style: GoogleFonts.robotoCondensed(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  height: 1,
                  width: 250,
                  child: Container(color: Colors.teal[700]),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Dinner: ",
                  style: GoogleFonts.robotoCondensed(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  height: 1,
                  width: 250,
                  child: Container(color: Colors.teal[700]),
                ),
              ),
            ),
          ],
        ),



















 Future getWednesday() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user.email!)
        .collection("Schedule")
        .doc("Wednesday")
        .get()
        .then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;

        setState(() {
          db = data["Breakfast"];
          dl = data["Lunch"];
          dd = data["Dinner"];
        });
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  Future getThursday() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user.email!)
        .collection("Schedule")
        .doc("Thursday")
        .get()
        .then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;

        setState(() {
          db = data["Breakfast"];
          dl = data["Lunch"];
          dd = data["Dinner"];
        });
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  Future getFriday() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user.email!)
        .collection("Schedule")
        .doc("Friday")
        .get()
        .then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;

        setState(() {
          db = data["Breakfast"];
          dl = data["Lunch"];
          dd = data["Dinner"];
        });
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  Future getSaturday() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user.email!)
        .collection("Schedule")
        .doc("Saturday")
        .get()
        .then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;

        setState(() {
          db = data["Breakfast"];
          dl = data["Lunch"];
          dd = data["Dinner"];
        });
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  Future getSunday() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user.email!)
        .collection("Schedule")
        .doc("Sunday")
        .get()
        .then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;

        setState(() {
          db = data["Breakfast"];
          dl = data["Lunch"];
          dd = data["Dinner"];
        });
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }












        */

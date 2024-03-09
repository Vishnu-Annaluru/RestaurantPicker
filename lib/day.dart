import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class Day extends StatefulWidget {
  final String day;

  const Day({Key? key, required this.day}) : super(key: key);

  @override
  State<Day> createState() => _DayState();
}

class _DayState extends State<Day> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.teal[500],
          borderRadius: BorderRadius.circular(20),
        ),
        height: 190,
        width: 170,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5.0, left: 5.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  widget.day,
                  style: GoogleFonts.robotoCondensed(
                      color: Colors.teal[900], fontSize: 25),
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
                  width: 200,
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
                  width: 200,
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
                  width: 200,
                  child: Container(color: Colors.teal[700]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

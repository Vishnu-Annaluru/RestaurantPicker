import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:restaurantpickerandroid/customlist.dart';
import 'package:restaurantpickerandroid/day.dart';
import 'week.dart';

class Schedule extends StatefulWidget {
  final Function(List) sinfoSaved;

  const Schedule({Key? key, required this.sinfoSaved}) : super(key: key);

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  int timeLeft = 20;
  int count = 0;
  late Timer _timer;

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
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

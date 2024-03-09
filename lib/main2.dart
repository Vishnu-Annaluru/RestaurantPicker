import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:restaurantpickerandroid/locationservice.dart';
import 'package:restaurantpickerandroid/search.dart';
import 'package:restaurantpickerandroid/searchmogus.dart';
import 'package:restaurantpickerandroid/temp.dart';
import 'package:restaurantpickerandroid/week.dart';
import 'settings.dart';
import 'main.dart';
import 'home.dart';
import 'schedule.dart';
import 'map.dart';
import 'search.dart';
//import 'package:restaurantpickerandroid/loginpage.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

class Main2 extends StatefulWidget {
  Main2({Key? key}) : super(key: key);

  @override
  _Main2State createState() => _Main2State();
}

class _Main2State extends State<Main2> {
  late List<Widget> pages;
  late List sendToHomeList = [];
  int _selected = 0;
  String? lat, long, country, adminArea;

  void _navigate(int index) {
    setState(() {
      _selected = index;
    });
  }

  @override
  void initState() {
    super.initState();
    pages = [
      Home(hinfoSaved: sendToHomeList),
      Map(),
      Search(),
      Settings(),
      SearchMogus(), //replace with temp
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selected,
        children: pages,
      ),
      bottomNavigationBar: Container(
        color: const Color.fromARGB(255, 17, 17, 17),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: GNav(
            backgroundColor: const Color.fromARGB(255, 17, 17, 17),
            color: Colors.white,
            activeColor: Colors.teal[100],
            tabBackgroundColor: Colors.teal.shade900,
            padding: const EdgeInsets.all(16),
            gap: 10,
            selectedIndex: _selected,
            onTabChange: (index) {
              _navigate(index);
            },
            tabs: const [
              GButton(
                icon: Icons.home,
                text: "Home",
              ),
              GButton(
                icon: Icons.location_on,
                text: "Map",
              ),
              GButton(
                icon: Icons.search,
                text: "Search",
              ),
              GButton(
                icon: Icons.settings,
                text: "Settings",
              ),
              GButton(
                icon: Icons.podcasts,
                text: "fds",
              ),
              

            ],
          ),
        ),
      ),
    );
  }
}

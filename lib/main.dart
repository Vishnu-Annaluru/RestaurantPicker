import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
//import 'package:restaurantpickerandroid/authpage.dart';
import 'package:restaurantpickerandroid/locationservice.dart';
import 'package:restaurantpickerandroid/main2.dart';
//import 'loginpage.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'userlocation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:google_fonts/google_fonts.dart';


void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  //await DotEnv().load(fileName: ".env");
  //await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserLocation>(
      create: (context) => LocationService().locationStream,
      initialData: UserLocation(latitude: 40.71, longitude: -74.00),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        restorationScopeId: "root",
        home: Main2(),
        theme: ThemeData(brightness: Brightness.dark, textTheme: GoogleFonts.robotoCondensedTextTheme(Theme.of(context).textTheme)),
      ),
    );
  }
}

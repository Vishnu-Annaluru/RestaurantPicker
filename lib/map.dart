import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import 'locationservice.dart';
import 'userlocation.dart';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  //String? lat, long, country, adminArea;

  late double latitude;
  late double longitude;
  final MapController controller = MapController();
  LatLng l = LatLng(40.71, -74);
  double zoomm = 18;

  @override
  void initState() {
    super.initState();
    controller.onReady;
    //getLocation();
  }

  /*
  void getLocation() async {
    print("GETLOCATION CLLAED");
    final service = LocationService();
    final locationData = await service.getLocation();

    if (locationData != null) {
      setState(() {

        service.onLocationChanged.listen()

        lat = locationData.latitude.toString();
        long = locationData.longitude.toString();
        print("LAT: " + lat! + "LONG: " + long!);

      });
    } else {
      print("Location data is null");
    }
  }
  */

  @override
  Widget build(BuildContext context) {
    var userLocation = Provider.of<UserLocation>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            FlutterMap(
              key: ValueKey(MediaQuery.of(context).orientation),
              options: MapOptions(
                center: l,
                zoom: zoomm,
                keepAlive: true,
                maxZoom: 18.3,
                enableScrollWheel: true,
                minZoom: 5.0,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ["a", "b", "c"],
                ),
                MarkerLayerOptions(
                  markers: [
                    Marker(
                      width: 45.0,
                      height: 45.0,
                      point: l,
                      builder: (context) => IconButton(
                        onPressed: () {
                          print("Marker pressed");
                        },
                        icon: const Icon(Icons.location_on),
                        color: Colors.red,
                        iconSize: 45.0,
                      ),
                    )
                  ],
                ),
              ],
              nonRotatedChildren: [
                AttributionWidget.defaultWidget(
                  source: 'OpenStreetMap contributors',
                  onSourceTapped: () {},
                ),
              ],
              mapController: controller,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 660,
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            latitude = userLocation.latitude;
                            longitude = userLocation.longitude;
                            l = LatLng(latitude, longitude);
                            zoomm = 18;
                            controller.move(l, 18);
                            controller.center;
                            print("LATITUDE: $latitude LONGITUDE: $longitude");
                          });
                        },
                        backgroundColor: Colors.teal.shade900,
                        child: const Icon(
                          Icons.center_focus_strong_sharp,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

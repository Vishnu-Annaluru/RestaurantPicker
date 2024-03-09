import 'dart:async';

import 'package:location/location.dart';

import 'userlocation.dart';

class LocationService {
  late UserLocation _currentLocation;

  Location location = Location();

  StreamController<UserLocation> _locationController =
      StreamController<UserLocation>.broadcast();

  LocationService() {
    location.requestPermission().then((value) {
      if (true) {
        location.onLocationChanged.listen((locationData) {
          if (locationData != null) {
            _locationController.add(
              UserLocation(
                  latitude: locationData.latitude!,
                  longitude: locationData.longitude!),
            );
          }
        });
      }
    });
  }

  Stream<UserLocation> get locationStream => _locationController.stream;

  Future<UserLocation> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation = UserLocation(
          latitude: userLocation.latitude!, longitude: userLocation.longitude!);
    } catch (e) {
      print("Could not get location: $e");
    }

    return _currentLocation;
  }
}


























































































/*import 'package:flutter/services.dart';
import 'package:location/location.dart';

class LocationService {
  late Location  _location;
  bool _serviceEnabled = false;
  PermissionStatus? _grantedPermission;

  LocationService() {
    _location = Location();
  }

  get onLocationChanged => null;

  Future<bool> _checkPermission() async {
    if (await _checkService()) {
      _grantedPermission = await _location.hasPermission();
      if (_grantedPermission == PermissionStatus.denied) {
        _grantedPermission = await _location.requestPermission();
      }
    }
    return _grantedPermission == PermissionStatus.granted;
  }

  Future<bool> _checkService() async {
    try {
      _serviceEnabled = await _location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await _location.requestService();
      }
    } on PlatformException catch (error) {
      print("error code is ${error.code} and message = ${error.message}");
      _serviceEnabled = false;
      await _checkService();
    }

    return _serviceEnabled;
  }

  Future<LocationData?> getLocation() async {
    if (await _checkPermission()) {
      final locationData = _location.getLocation();
      return locationData;
    }
    return null;
  }
}
*/

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapProvider extends ChangeNotifier {
  double latitude = 37.5666805;      // default latitude
  double longitude = 126.9784147;    // default longitude
  double zoom = 14;    // default zoom level

  CameraPosition getCameraPosition() {
    return CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: zoom,
    );
  }

  Future<void> checkLocationPermission() async {

  }

  Future<void> initCurrentLocation() async {

  }

  Future<void> initAndroidGoogleMapViewMode() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt! >= 29) {
        AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
      }
    }
  }
}
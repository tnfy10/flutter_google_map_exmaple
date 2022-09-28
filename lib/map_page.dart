import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_map_example/map_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _completer = Completer();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<MapProvider>(context, listen: false).fetchCurrentLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<MapProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('구글 지도 예제'),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: mapProvider.getCameraPosition(),
          onMapCreated: (GoogleMapController controller) {
            _completer.complete(controller);
          },
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          rotateGesturesEnabled: false,
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => showCurrentLocation(mapProvider),
          child: const Icon(Icons.location_searching)),
    );
  }

  void showCurrentLocation(MapProvider mapProvider) async {
    await mapProvider.fetchCurrentLocation();
    final cameraPosition = mapProvider.getCameraPosition();
    final cameraUpdate = CameraUpdate.newCameraPosition(cameraPosition);
    final controller = await _completer.future;
    controller.animateCamera(cameraUpdate);
  }
}

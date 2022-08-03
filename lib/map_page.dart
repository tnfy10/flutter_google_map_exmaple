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
  final Completer<GoogleMapController> _controller = Completer();
  late MapProvider _mapProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _mapProvider = Provider.of<MapProvider>(context, listen: false);
      _mapProvider.initAndroidGoogleMapViewMode();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('구글 지도 예제'),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Consumer<MapProvider>(
          builder: (context, mapProvider, child) => GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: mapProvider.getCameraPosition(),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {

          },
          child: const Icon(Icons.location_searching)),
    );
  }
}

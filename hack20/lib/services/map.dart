import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressMap extends StatefulWidget {
  @override
  _AddressMapState createState() => _AddressMapState();
}

class _AddressMapState extends State<AddressMap> {
  Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GoogleMap(
        onMapCreated: (GoogleMapController controller) async {
          _controller.complete(controller);
        },
        initialCameraPosition: CameraPosition(target: LatLng(12.08, 82.012), zoom: 15),
        mapType: MapType.normal,
      )
    );
  }
}

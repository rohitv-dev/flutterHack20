import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SampleMap extends StatefulWidget {
  @override
  _SampleMapState createState() => _SampleMapState();
}

class _SampleMapState extends State<SampleMap> {

  GoogleMapController mapController;
  final LatLng _center = const LatLng(45.521563, -122.677433);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    double _defaultOpen = MediaQuery.of(context).size.height * .60;
    return SlidingUpPanel(
      defaultPanelState: PanelState.OPEN,
      maxHeight: MediaQuery.of(context).size.height * .80,
      borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0),topRight: Radius.circular(40.0)),
      isDraggable: true,
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 15
        ),
      ),
      panel: Container(),
    );
  }
}

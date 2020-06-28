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
      panelBuilder: (sc) => _panel(sc,context),
    );
  }

  Widget _panel(ScrollController sc,context){
    String name;
    String phoneNo;
    String doorNo;
    String floorNo;
    String addressLine;
    String city;
    String pincode;
    return ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            Text("Add Address"),
            SizedBox(
              height: 20.0,
            ),
            Text("Name"),
            TextField(
              onChanged: (fieldName){
                setState(() {
                  name = fieldName;
                });
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            Text("Phone Number"),
            TextField(onChanged: (fieldPhone){
              setState(() {
                phoneNo = fieldPhone;
              });
            },),
            Text("Door No"),
            TextField(onChanged: (fieldDoor){
              setState(() {
                doorNo = fieldDoor;
              });
            },),
            Text("Floor No"),
            TextField(
              onChanged: (fieldFloor){
                setState(() {
                  floorNo = fieldFloor;
                });
              },
            ),
            Text("Address Line"),
            TextField(onChanged: (fieldAddress){
              setState(() {
                addressLine = fieldAddress;
              });
            },),
            Text("city"),
            TextField(onChanged: (fieldCity){
              setState(() {
                city = fieldCity;
              });
            },),
            Text("Pincode"),
            TextField(onChanged: (fieldPin){
              setState(() {
                pincode = fieldPin;
              });
            },),
            SizedBox(
              height: 20.0,
            ),
            FlatButton(
              color: Colors.red,
              onPressed: (){
                print(name+phoneNo+doorNo+floorNo+addressLine+city+pincode);

              },
              child: Text(
                "Save",
                style: TextStyle(
                    color: Colors.white
                ),
              ),
            )
          ],
        ),
      ],
    );

  }
}

import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hack20/models/sharedModel.dart';
import 'package:hack20/models/userModel.dart';
import 'package:hack20/services/database.dart';
import 'package:hack20/shared/functions/displayToast.dart';
import 'package:hack20/shared/loading.dart';
import 'package:hack20/shared/textDecoration.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AddressEdit extends StatefulWidget {
  @override
  _AddressEditState createState() => _AddressEditState();
}

class _AddressEditState extends State<AddressEdit> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final double _initFabHeight = 210.0;
  double _closedFabHeight = 210.0;
  double _fabHeight;
  double _panelHeightOpen;
  double _panelHeightClosed = 210.0;
  bool _draggable = true;
  var _nameFieldEnable = true;

  static dynamic lat = 12.837793;
  static dynamic lon = 80.204428;
  static dynamic mapZoom = 15.0;
  static dynamic mapLock = true;
  static dynamic curLat = 0;
  static dynamic curLon = 0;

  String _name = '.';
  String _doorNo = '.';
  String _floorNo = '.';
  String _address = '.';
  String _city = '.';
  String _pinCode = '.';

  bool _isChecked = false;

  final _formKey = GlobalKey<FormState>();
  Completer<GoogleMapController> _controller = Completer();
  static LatLng _center = LatLng(lat, lon);
  static LatLng _lastMapPosition;
  MapType _currentMapType = MapType.normal;
  Color iconColor = Colors.brown[500];
  var _showGoogleMaps = false;

  _toggleMapType() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal ? MapType.satellite : MapType.normal;
    });
  }

  @override
  void initState() {
    super.initState();
    _fabHeight = _initFabHeight;
    _showGoogleMaps = true;
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    _panelHeightOpen = MediaQuery.of(context).size.height * .60;

    Widget updateAddressForm(UserNGOAddress addressData) {
      return Column(children: [
        Text(
          'Update $_name Address',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20.0),
        SizedBox(
          width: 270,
          child: TextFormField(
            enabled: _nameFieldEnable,
            initialValue: _isChecked ? _name : addressData.name,
            decoration: textInputDecoration.copyWith(hintText: 'Name', labelText: 'Name'),
            validator: (val) => val.isEmpty ? 'Please enter a name' : null,
            onChanged: (val) => setState(() => _name = val),
          ),
        ),
        SizedBox(height: 10.0),
        SizedBox(
          width: 270,
          child: TextFormField(
            initialValue: _isChecked ? _doorNo : addressData.doorNo,
            decoration: textInputDecoration.copyWith(hintText: 'Door No', labelText: 'Door No'),
            validator: (val) => val.isEmpty ? 'Please enter a Door No' : null,
            onChanged: (val) => setState(() => _doorNo = val),
          ),
        ),
        SizedBox(height: 10.0),
        SizedBox(
          width: 270,
          child: TextFormField(
            initialValue: _isChecked ? _floorNo : addressData.floorNo,
            keyboardType: TextInputType.number,
            decoration: textInputDecoration.copyWith(hintText: 'Floor No', labelText: 'Floor No'),
            validator: (val) => val.isEmpty ? 'Please enter the Floor No' : null,
            onChanged: (val) => setState(() => _floorNo = val),
          ),
        ),
        SizedBox(height: 10.0),
        SizedBox(
          width: 270,
          child: TextFormField(
            initialValue: _isChecked ? _address : addressData.addressLine,
            decoration: textInputDecoration.copyWith(hintText: 'Address', labelText: 'Address'),
            validator: (val) => val.isEmpty ? 'Please enter address line' : null,
            onChanged: (val) => setState(() => _address = val),
          ),
        ),
        SizedBox(height: 10.0),
        SizedBox(
          width: 270,
          child: TextFormField(
            initialValue: _isChecked ? _city : addressData.city,
            decoration: textInputDecoration.copyWith(hintText: 'City', labelText: 'City'),
            validator: (val) => val.isEmpty ? 'Please enter the city' : null,
            onChanged: (val) => setState(() => _city = val),
          ),
        ),
        SizedBox(height: 10.0),
        SizedBox(
          width: 270,
          child: TextFormField(
            initialValue: _isChecked ? _pinCode : addressData.pinCode,
            decoration: textInputDecoration.copyWith(hintText: 'Pin Code', labelText: 'Pin Code'),
            validator: (val) => val.isEmpty ? 'Please enter the pincode' : null,
            onChanged: (val) => setState(() => _pinCode = val),
          ),
        ),
        SizedBox(height: 15.0),
        SizedBox(
          width: 150.0,
          height: 40.0,
          child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              color: Colors.green,
              child: Text(
                'Update',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  Navigator.pop(context, true);
                }
              }),
        ),
      ]);
    }

    void _showUpdatePanel(UserNGOAddress addressData) {
      showDialog(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Dialog(
              insetAnimationDuration: Duration(milliseconds: 1000),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(
                    color: Colors.grey[800],
                    width: 3,
                  )),
              elevation: 5.0,
              backgroundColor: Colors.transparent,
              child: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  SizedBox(
                    height: 550,
                    width: 350,
                    child: Container(
                      decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                      child: Form(
                        key: _formKey,
                        child: Container(child: updateAddressForm(addressData)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    Widget _panel(ScrollController sc, User user, UserNGOAddress addressData) {
      return MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView(
            controller: sc,
            children: <Widget>[
              SizedBox(
                height: 12.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      width: 30,
                      height: 5,
                      decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.all(Radius.circular(12.0))),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(flex: 1, child: Text('  ')),
                      Expanded(
                        flex: 1,
                        child: Text(
                          '    Address',
                          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              _showUpdatePanel(addressData);
                            },
                            child: Icon(
                              Icons.edit,
                              size: 27.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width:10.0),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  SizedBox(
                    width: 300,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 10.0),
                          Row(
                            children: <Widget>[
                              SizedBox(width: 30.0),
                              SizedBox(
                                width: 110,
                                child: Text(
                                  'Name :',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  _isChecked ? _name : (_name == '.' ? addressData.name : _name),
                                  style: TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            children: <Widget>[
                              SizedBox(width: 30.0),
                              SizedBox(
                                width: 110,
                                child: Text(
                                  'Door No :',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  _isChecked ? _doorNo : (_doorNo == '.' ? addressData.doorNo : _doorNo),
                                  style: TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            children: <Widget>[
                              SizedBox(width: 30.0),
                              SizedBox(
                                width: 110,
                                child: Text(
                                  'Floor No :',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  _isChecked ? _floorNo : (_floorNo == '.' ? addressData.floorNo : _floorNo),
                                  style: TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            children: <Widget>[
                              SizedBox(width: 30.0),
                              SizedBox(
                                width: 110,
                                child: Text(
                                  'Address line 1 :',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  _isChecked ? _address : (_address == '.' ? addressData.addressLine : _address),
                                  style: TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            children: <Widget>[
                              SizedBox(width: 30.0),
                              SizedBox(
                                width: 110,
                                child: Text(
                                  'City :',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  _isChecked ? _city : (_city == '.' ? addressData.city : _city),
                                  style: TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            children: <Widget>[
                              SizedBox(width: 30.0),
                              SizedBox(
                                width: 110,
                                child: Text(
                                  'Pincode :',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  _isChecked ? _pinCode : (_pinCode == '.' ? addressData.pinCode : _pinCode),
                                  style: TextStyle(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  SizedBox(
                    width: 150.0,
                    height: 40.0,
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        color: _isChecked ? Colors.green : Colors.grey,
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_isChecked) {
                            await DatabaseService(uid: user.uid).updateAddressData(
                                _name, _doorNo, _floorNo, _address, _city, _pinCode, _lastMapPosition.latitude, _lastMapPosition.longitude);
                            showLongToast('Address updated', 2);
                            Navigator.pop(context);
                          } else {
                            showLongToast('Kindly click the tick button', 2);
                          }
                        }),
                  ),
                ],
              ),
            ],
          ));
    }

    Widget _body() {
      _onMapCreated(GoogleMapController controller) async {
        _controller.complete(controller);
      }

      _onCameraMove(CameraPosition position) {
        if (mapLock == true) {
          _lastMapPosition = position.target;
        }
      }

      if (_showGoogleMaps == true) {
        return Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: mapZoom,
              ),
              mapType: _currentMapType,
              onCameraMove: _onCameraMove,
            ),
            Center(
              child: Icon(
                Icons.location_on,
                color: Color.fromRGBO(100, 120, 251, 1),
                size: 40.0,
              ),
            ),
          ],
        );
      } else {
        return Container();
      }
    }

    _getLocation() async {
      final curPosition = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        curLat = curPosition.latitude;
        curLon = curPosition.longitude;
      });
    }

    Future<void> _gotoMyLocation() async {
      await _getLocation();
      CameraPosition curPosition = CameraPosition(
        target: LatLng(curLat, curLon),
        zoom: 18.0,
      );
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(curPosition));
    }

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _scaffoldKey,
        body: StreamBuilder<UserNGOAddress>(
          stream: DatabaseService(uid: user.uid).userNgosAddressData,
          builder: (context, snapshot) {
           if (snapshot.hasData) {
             return Stack(
               alignment: Alignment.topCenter,
               children: <Widget>[
                 SlidingUpPanel(
                   isDraggable: _draggable,
                   maxHeight: _panelHeightOpen,
                   minHeight: _panelHeightClosed,
                   parallaxEnabled: true,
                   defaultPanelState: PanelState.CLOSED,
                   parallaxOffset: .5,
                   body: _body(),
                   panelBuilder: (sc) => _panel(sc, user, snapshot.data),
                   borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
                   onPanelSlide: (double pos) => setState(() {
                     _fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) + _closedFabHeight;
                   }),
                 ),
                 Positioned(
                   right: 20.0,
                   bottom: _fabHeight + 20,
                   child: FloatingActionButton(
                     child: Icon(
                       Icons.check,
                       color: Colors.black,
                     ),
                     onPressed: () async {
                       lat = _lastMapPosition.latitude;
                       lon = _lastMapPosition.longitude;

                       final coordinates = new Coordinates(_lastMapPosition.latitude, _lastMapPosition.longitude);
                       var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
                       var data = addresses.first;
                       setState(() {
                         _doorNo = data.featureName;
                         _address = data.thoroughfare ?? '' + ',' + data.subLocality ?? '';
                         _city = data.locality;
                         _pinCode = data.postalCode;
                       });

                       setState(() {
                         _isChecked = true;
                       });
                     },
                     backgroundColor: Colors.white,
                   ),
                 ),
                 //Location Button
                 Positioned(
                   right: 20.0,
                   bottom: _fabHeight + 90,
                   child: FloatingActionButton(
                     heroTag: 'location',
                     child: Icon(
                       Icons.my_location,
                       color: Colors.black,
                     ),
                     onPressed: _gotoMyLocation,
                     backgroundColor: Colors.white,
                   ),
                 ),
                 Positioned(
                     top: 0,
                     child: ClipRRect(
                         child: BackdropFilter(
                             filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                             child: Container(
                               width: MediaQuery.of(context).size.width,
                               height: MediaQuery.of(context).padding.top,
                               color: Colors.transparent,
                             )))),
                 //Toggle Map
                 Positioned(
                   left: 20.0,
                   bottom: _fabHeight + 20,
                   child: FloatingActionButton(
                     heroTag: 'togglemap',
                     child: Icon(
                       Icons.map,
                       color: Colors.black,
                     ),
                     onPressed: () {
                       _toggleMapType();
                     },
                     backgroundColor: Colors.white,
                   ),
                 ),
                 //Back Button
                 Positioned(
                   top: 52.0,
                   left: 20.0,
                   child: FloatingActionButton(
                     heroTag: 'back button',
                     child: Icon(
                       Icons.arrow_back,
                       color: Colors.black,
                     ),
                     onPressed: () {
                       Navigator.pop(context);
                     },
                     backgroundColor: Colors.white,
                   ),
                 ),
               ],
             );
           } else {return Loading();}
          }
        ));
  }
}

import 'package:flutter/material.dart';

class PanelContents extends StatefulWidget {
  @override
  _PanelContentsState createState() => _PanelContentsState();
}

class _PanelContentsState extends State<PanelContents> {
  String name;
  String phoneNo;
  String doorNo;
  String floorNo;
  String addressLine;
  String city;
  String pincode;


  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}

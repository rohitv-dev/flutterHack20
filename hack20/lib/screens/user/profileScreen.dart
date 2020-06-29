import 'package:flutter/material.dart';
import 'package:hack20/services/addressEdit.dart';
import 'package:hack20/services/auth.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Column(
        children: <Widget>[
          Container(
            height: 210,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.green,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 90.0, left: 20.0, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.grey[500],
                      blurRadius: 10.0,
                      spreadRadius: 0.0,
                      offset: Offset(2.0, 2.0), // shadow direction: bottom right
                    )
                  ], color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(flex: 1, child: Text('')),
                            Expanded(
                              flex: 1,
                              child: Icon(
                                Icons.home,
                                color: Colors.green[500],
                                size: 40.0,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddressEdit()));
                                    },
                                    child: Icon(Icons.edit),
                                  )),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0, top: 20.0),
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 110,
                                child: Text(
                                  'Door No :',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                '10A',
                                style: TextStyle(),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0, top: 10.0),
                          child: Row(
                            children: <Widget>[
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
                                  'Kalingarayan main street',
                                  style: TextStyle(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0, top: 10.0),
                          child: Row(
                            children: <Widget>[
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
                                  'Chennai',
                                  style: TextStyle(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0, top: 10.0),
                          child: Row(
                            children: <Widget>[
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
                                  '600021',
                                  style: TextStyle(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(top: 70, right: 20.0, left: 20.0),
        child: Container(
          height: 200.0,
          width: MediaQuery.of(context).size.width,
          decoration: new BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey[500],
                blurRadius: 10.0,
                spreadRadius: 0.0,
                offset: Offset(2.0, 2.0), // shadow direction: bottom right
              )
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(flex: 1, child: Text('')),
                  Expanded(
                    flex: 1,
                    child: Container(
                      transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                      width: 100,
                      height: 100,
                      decoration: new BoxDecoration(shape: BoxShape.circle, color: Colors.grey[200], boxShadow: [
                        BoxShadow(
                          color: Colors.grey[500],
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                          offset: Offset(2.0, 2.0), // shadow direction: bottom right
                        )
                      ]),
                      child: Icon(
                        Icons.person,
                        size: 70,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                          transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: GestureDetector(
                              onTap: () {
                                print('edit screen called');
                              },
                              child: Icon(Icons.edit),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
              Container(
                  transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Text(
                          'Hemantharajan',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text(
                          'Name',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      'sample@gmail.com',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Email',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  '9940632194',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Phone',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
      )
    ]);
  }
}

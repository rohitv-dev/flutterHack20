import 'package:flutter/material.dart';
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
            height: 220,
            decoration: new BoxDecoration(
              color: Colors.green,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 130.0, left: 20.0, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[500],
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                          offset:
                              Offset(2.0, 2.0), // shadow direction: bottom right
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0)),
                  height: 240,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.home,
                          color: Colors.grey[500],
                          size: 40.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0, top: 30.0),
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
                ),
                Padding(
                  padding: const EdgeInsets.only( top: 30.0),
                  child: GestureDetector(
                    onTap: () {
                      AuthService().signOut();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                            Icons.exit_to_app,
                            color: Colors.grey[500]
                        ),
                        Text('Logout from my account',
                        style: TextStyle(
                          color: Colors.grey[500]
                        ),)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      new Container(
        alignment: Alignment.topCenter,
        padding: new EdgeInsets.only(
            top: MediaQuery.of(context).size.height * .12,
            right: 20.0,
            left: 20.0),
        child: new Container(
          height: 220.0,
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
              Container(
                transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                width: 120,
                height: 120,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[500],
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                        offset:
                            Offset(2.0, 2.0), // shadow direction: bottom right
                      )
                    ]),
                child: Icon(
                  Icons.person,
                  size: 70,
                  color: Colors.grey,
                ),
              ),
              Container(
                  transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Text(
                          'Hemantharajan',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 1.0),
                        child: Text(
                          'Name',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      'sample@gmail.com',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
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

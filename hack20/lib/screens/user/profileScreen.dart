import 'package:flutter/material.dart';
import 'package:hack20/models/sharedModel.dart';
import 'package:hack20/models/userModel.dart';
import 'package:hack20/services/addressEdit.dart';
import 'package:hack20/services/auth.dart';
import 'package:hack20/services/database.dart';
import 'package:hack20/shared/loading.dart';
import 'package:hack20/shared/textDecoration.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    String _userName, _phoneNumber;
    final _profFormKey = GlobalKey<FormState>();

    updateProfileDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              insetAnimationDuration: Duration(milliseconds: 1000),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(
                    color: Colors.grey[800],
                    width: 3,
                  )),
              elevation: 5.0,
              child: SingleChildScrollView(
              child: Form(
                key: _profFormKey,
                child: Container(
                  width: 500, height: 250,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20),
                      Text(
                        'Update Profile Data',
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20.0),
                      SizedBox(
                        width: 270,
                        child: TextFormField(
                          initialValue: _userName,
                          decoration: textInputDecoration.copyWith(hintText: 'Name', labelText: 'Name'),
                          validator: (val) => val.isEmpty ? 'Please enter your name' : null,
                          onChanged: (val) => setState(() => _userName = val),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      SizedBox(
                        width: 270,
                        child: TextFormField(
                          initialValue: _phoneNumber,
                          keyboardType: TextInputType.number,
                          decoration: textInputDecoration.copyWith(hintText: 'Phone Number', labelText: 'Phone Number'),
                          validator: (val) => val.isEmpty ? 'Please enter your phone number' : null,
                          onChanged: (val) => setState(() => _phoneNumber = val),
                        ),
                      ),
                      SizedBox(height: 20),
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
                              if (_profFormKey.currentState.validate()) {
                                DatabaseService(uid: user.uid).updateProfileData(_userName, _phoneNumber);
                                Navigator.pop(context, true);
                              }
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            )
          );
        }
      );
    }

    return StreamBuilder<UserNGOAddress>(
      stream: DatabaseService(uid: user.uid).userNgosAddressData,
      builder: (context, adSnap) {
        if (!adSnap.hasData) return Loading();
        UserNGOAddress addressData = adSnap.data;
        return StreamBuilder<UserProfile>(
          stream: DatabaseService(uid: user.uid).userProfileData,
          builder: (context, profSnap) {
            if (!profSnap.hasData) return Loading();
            UserProfile userProf = profSnap.data;
            return Stack(children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: 210,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(99, 107, 255, 1),
                            Color.fromRGBO(130, 136, 255, 0.9),
                          ]
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 160.0, left: 20.0, right: 20),
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
                                  offset: Offset(2.0, 2.0), // shadow direction: bottom right
                                )
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)),
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
                                        color: Color.fromRGBO(100, 120, 251, 1),
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
                                        addressData.doorNo,
                                        style: TextStyle(),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(left: 30.0, top: 10.0),
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
                                          addressData.addressLine,
                                          style: TextStyle(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(left: 30.0, top: 10.0),
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
                                          addressData.city,
                                          style: TextStyle(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 30.0, top: 10.0),
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 110,
                                        child: Text(
                                          'Pin Code :',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          addressData.pinCode,
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
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: GestureDetector(
                      onTap: () async{
                        await _auth.signOut();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.exit_to_app,
                            color: Colors.grey[400],
                          ),
                          Text(
                            'Signout from my account',
                            style: TextStyle(
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 130, right: 20.0, left: 20.0),
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
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[200],
                                  boxShadow: [
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
                                        setState(() {
                                          _userName = userProf.userName;
                                          _phoneNumber = userProf.phoneNumber;
                                        });
                                        updateProfileDialog();
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
                                  userProf.userName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 16),
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
                                              user.email,
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
                                          userProf.phoneNumber,
                                          style:
                                          TextStyle(fontWeight: FontWeight.bold),
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
        );
      }
    );
  }
}

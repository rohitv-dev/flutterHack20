import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hack20/models/sharedModel.dart';
import 'package:hack20/models/userModel.dart';
import 'package:hack20/services/database.dart';
import 'package:hack20/shared/loading.dart';
import 'package:hack20/shared/textDecoration.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:response/response.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FoodRegisterScreen extends StatefulWidget {
  final String url;
  final String productName;
  final String productDesc;
  final int count;

  FoodRegisterScreen(
      {this.url, this.productName, this.productDesc, this.count});

  @override
  _FoodRegisterScreenState createState() => _FoodRegisterScreenState();
}

class _FoodRegisterScreenState extends State<FoodRegisterScreen> {
  String url;
  String productName;
  String productDesc;
  int count;

  final res = ResponseUI.instance;

  static FirebaseStorage storage = FirebaseStorage.instance;

  File imageFile;

  _openGallery(BuildContext context) async {
    // ignore: deprecated_member_use
    final picker = ImagePicker();
    var pickedFile = await picker.getImage(source: ImageSource.gallery);

    this.setState(() {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });

    Navigator.of(context).pop();

    String fileName = basename(imageFile.path);

    Reference reference = storage.ref().child("productImages/$fileName");

    UploadTask uploadTask = reference.putFile(imageFile);

    TaskSnapshot taskSnapshot = await uploadTask.snapshot;

    url = await taskSnapshot.ref.getDownloadURL();

    print("URL String :" + url);
  }

  _openCamera(BuildContext context) async {
    // ignore: deprecated_member_use
    final picker = ImagePicker();
    var pickedFile = await picker.getImage(source: ImageSource.camera);
    this.setState(() {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });

    Navigator.of(context).pop();

    String fileName = basename(imageFile.path);

    Reference reference = storage.ref().child("productImages/$fileName");

    UploadTask uploadTask = reference.putFile(imageFile);

    TaskSnapshot taskSnapshot = await uploadTask.snapshot;

    url = await taskSnapshot.ref.getDownloadURL();

    print("URL String :" + url);
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(res.setFontSize(15.0))),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _openCamera(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _decideImageView() {
    if (imageFile == null) {
      return Image.asset('assets/upload.jpg');
    } else {
      return Image.file(imageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    AppUser user = Provider.of<AppUser>(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color.fromRGBO(99, 107, 255, 1),
                    Color.fromRGBO(130, 136, 255, 0.9)
                  ]),
            ),
            child: StreamBuilder<UserNGOAddress>(
                stream: DatabaseService(uid: user.uid).userNgosAddressData,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Loading();
                  UserNGOAddress addressData = snapshot.data;
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  top: res.setHeight(30.0),
                                  left: res.setWidth(3.0)),
                              child: GestureDetector(
                                  child: Icon(Icons.arrow_back,
                                      color: Colors.white,
                                      size: res.setFontSize(28.0)),
                                  onTap: () {
                                    Navigator.pop(context);
                                  }),
                            ),
                          ],
                        ),
                        SizedBox(height: res.setHeight(10.0)),
                        Container(
                          child: Column(
                            children: <Widget>[
                              InkWell(
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    width:
                                        MediaQuery.of(context).size.width * .9,
                                    child: FittedBox(
                                      child: _decideImageView(),
                                      fit: BoxFit.fill,
                                    )),
                                onTap: () {
                                  _showChoiceDialog(context);
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: res.setHeight(5.0)),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: res.setWidth(8.0)),
                          child: Card(
                            elevation: 5,
                            margin: EdgeInsets.all(res.setFontSize(10.0)),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(res.setFontSize(30.0)),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(res.setFontSize(20.0)),
                              child: Form(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    TextFormField(
                                      onChanged: (val) {
                                        setState(() => productName = val);
                                      },
                                      decoration: textInputDecoration.copyWith(
                                        hintText: 'Item Name',
                                        labelText: 'Item Name',
                                        labelStyle:
                                            TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                    SizedBox(height: res.setHeight(10.0)),
                                    TextFormField(
                                      keyboardType: TextInputType.multiline,
                                      onChanged: (val) {
                                        setState(() => productDesc = val);
                                      },
                                      maxLines: null,
                                      decoration: textInputDecoration.copyWith(
                                        hintText: 'Item Description',
                                        labelText: 'Item Description',
                                        labelStyle:
                                            TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                    SizedBox(height: res.setHeight(10.0)),
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      onChanged: (val) {
                                        setState(() => count = int.parse(val));
                                      },
                                      decoration: textInputDecoration.copyWith(
                                        hintText: 'Serves(No.of Persons)',
                                        labelText: 'Serves(No.of Persons)',
                                        labelStyle:
                                            TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                    SizedBox(height: res.setHeight(10.0)),
                                    RaisedButton(
                                        color: Color.fromRGBO(100, 120, 251, 1),
                                        child: Text(
                                          'Save Details',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ),
                                        onPressed: () async {
                                          DateTime defaultBestBefore =
                                              DateTime.now()
                                                  .add(Duration(hours: 24));
                                          var foodCount =
                                              await DatabaseService()
                                                  .getFoodCount();
                                          await DatabaseService().setFoodData(
                                              '${foodCount['count'] + 1}',
                                              productName,
                                              user.email,
                                              addressData.latitude,
                                              addressData.longitude,
                                              count,
                                              Timestamp.now(),
                                              Timestamp.fromDate(
                                                  defaultBestBefore),
                                              false,
                                              '',
                                              url);
                                          await DatabaseService()
                                              .updateFoodCount(
                                                  foodCount['count'] + 1);
                                          Navigator.pop(context);
                                        }),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                })));
  }
}

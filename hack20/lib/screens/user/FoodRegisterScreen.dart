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

  FoodRegisterScreen({this.url, this.productName, this.productDesc, this.count});

  @override
  _FoodRegisterScreenState createState() => _FoodRegisterScreenState();
}

class _FoodRegisterScreenState extends State<FoodRegisterScreen> {
  String url;
  String productName;
  String productDesc;
  int count;

  var response = ResponseUI.instance;

  static FirebaseStorage storage = FirebaseStorage.instance;

  File imageFile;

  _openGallery(BuildContext context) async {
    // ignore: deprecated_member_use
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);

    this.setState(() {
      imageFile = picture;
    });

    Navigator.of(context).pop();

    String fileName = basename(imageFile.path);

    StorageReference reference = storage.ref().child("productImages/$fileName");

    StorageUploadTask uploadTask = reference.putFile(imageFile);

    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

    url = await taskSnapshot.ref.getDownloadURL();

    print("URL String :" + url);
  }

  _openCamera(BuildContext context) async {
    // ignore: deprecated_member_use
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });

    Navigator.of(context).pop();

    String fileName=basename(imageFile.path);

    StorageReference reference = storage.ref().child("productImages/$fileName");

    StorageUploadTask uploadTask = reference.putFile(imageFile);

    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

    url = await taskSnapshot.ref.getDownloadURL();

    print("URL String :" + url);

  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Make a choice"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(response.setFontSize(18.0))),
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
      return Text("No Image Selected");
    } else {
      return Image.file(imageFile, width: response.setWidth(200.0), height: response.setHeight(200.0));
    }
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: true,
      body: StreamBuilder<UserNGOAddress>(
        stream: DatabaseService(uid: user.uid).userNgosAddressData,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Loading();
          UserNGOAddress addressData = snapshot.data;
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(response.setFontSize(20.0)),
              child: Container(
                // height: response.setHeight(200),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: response.setHeight(250),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            _decideImageView(),
                            RaisedButton(
                              color: Colors.blue[400],
                              onPressed: () {
                                _showChoiceDialog(context);
                              },
                              child: Text(
                                "Select Image",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Form(
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: response.setHeight(10.0)),
                              TextFormField(
                                  onChanged: (val) {
                                    setState(() => productName = val);
                                  },
                                  decoration: textInputDecoration.copyWith(hintText: 'Product Name', labelText: 'Product Name')),
                              SizedBox(height: response.setHeight(10.0)),
                              TextFormField(
                                  keyboardType: TextInputType.multiline,
                                  onChanged: (val) {
                                    setState(() => productDesc = val);
                                  },
                                  maxLines: null,
                                  decoration: textInputDecoration.copyWith(hintText: 'Product Description', labelText: 'Product Description')
                              ),
                              SizedBox(height: response.setHeight(10.0)),
                              TextFormField(
                                  keyboardType: TextInputType.number,
                                  onChanged: (val) {
                                    setState(() => count = int.parse(val));
                                  },
                                  decoration: textInputDecoration.copyWith(hintText: 'Count', labelText: 'Count')),
                              SizedBox(height: response.setHeight(10.0)),
                              RaisedButton(
                                  color: Colors.blue[400],
                                  child: Text(
                                    'Save Details',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    DateTime defaultBestBefore = DateTime.now().add(Duration(hours: 24));
                                    var foodCount = await DatabaseService().getFoodCount();
                                    await DatabaseService().setFoodData(
                                        '${foodCount['count'] + 1}', productName, user.email, addressData.latitude, addressData.longitude,
                                        count, Timestamp.now(), Timestamp.fromDate(defaultBestBefore), false, '', url
                                    );
                                    await DatabaseService().updateFoodCount(foodCount['count'] + 1);
                                    Navigator.pop(context);
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}

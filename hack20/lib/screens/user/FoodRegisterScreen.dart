import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hack20/models/userModel.dart';
import 'package:hack20/services/database.dart';
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

    String fileName = basename(imageFile.path);

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
                  Padding(padding: EdgeInsets.all(response.setFontSize(15.0))),
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
      return Image.asset('assets/upload.jpg',width: 100, height: 100);
    } else {
      return Image.file(imageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Details',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            InkWell(
              child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  child: FittedBox(
                child: _decideImageView(),
                fit: BoxFit.fill,
              )
              ),
                onTap: () {
                  _showChoiceDialog(context);
                },
            ),
            Card(
              elevation: 5,
              margin: EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(height: response.setHeight(10.0)),
                      TextFormField(
                          onChanged: (val) {
                            setState(() => productName = val);
                          },
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Item Name',
                              labelText: 'Item Name',
                              labelStyle: TextStyle(color: Colors.grey),
                          ),
                         ),
                      SizedBox(height: response.setHeight(10.0)),
                      TextFormField(
                          keyboardType: TextInputType.multiline,
                          onChanged: (val) {
                            setState(() => productDesc = val);
                          },
                          maxLines: null,
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Item Description',
                              labelText: 'Item Description',
                        labelStyle: TextStyle(color: Colors.grey),
                          ),
                      ),
                      SizedBox(height: response.setHeight(10.0)),
                      TextFormField(
                          keyboardType: TextInputType.number,
                          onChanged: (val) {
                            setState(() => count = int.parse(val));
                          },
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Serves(No.of Persons)', labelText: 'Serves(No.of Persons)',
                              labelStyle: TextStyle(color: Colors.grey),
                          ),
                      ),
                      SizedBox(height: response.setHeight(10.0)),
                      RaisedButton(
                          color: Colors.blue,
                          child: Text(
                            'Save Details',
                            style: TextStyle(color: Colors.white),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          onPressed: () async {
                            DateTime defaultBestBefore =
                                DateTime.now().add(Duration(hours: 24));
                            var foodCount =
                                await DatabaseService().getFoodCount();
                            await DatabaseService().setFoodData(
                                '${foodCount['count'] + 1}',
                                productName,
                                user.email,
                                0.0,
                                0.0,
                                count,
                                Timestamp.now(),
                                Timestamp.fromDate(defaultBestBefore),
                                true,
                                false,
                                '',
                                url);
                            await DatabaseService()
                                .updateFoodCount(foodCount['count'] + 1);
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


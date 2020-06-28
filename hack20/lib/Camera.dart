import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hack20/database.dart';
import 'package:response/response.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class LandingScreen extends StatefulWidget {


  final String url;
  final String productName;
  final String productDesc;
  final int count;

  LandingScreen({this.url,this.productName,this.productDesc,this.count});

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {

  String url;
  String productName;
  String productDesc;
  int count;

  var response = ResponseUI.instance;

  static FirebaseStorage storage = FirebaseStorage.instance;

 static StorageReference reference = storage.ref().child("productImages/");

  File imageFile;

  _openGallery(BuildContext context) async{
    // ignore: deprecated_member_use
    var picture=await ImagePicker.pickImage(source:ImageSource.gallery);

    this.setState(() {
      imageFile=picture;
    });

    StorageUploadTask uploadTask = reference.putFile(imageFile);

    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

    url = await taskSnapshot.ref.getDownloadURL();


    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async{
    // ignore: deprecated_member_use
    var picture=await ImagePicker.pickImage(source:ImageSource.camera);
    this.setState(() {
      imageFile=picture;
    });

    StorageUploadTask uploadTask = reference.putFile(imageFile);

    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

    url = await taskSnapshot.ref.getDownloadURL();

    print("URL String :" + url);

    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context){
    return showDialog(context: context,builder:(BuildContext context){
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
              Padding(padding: EdgeInsets.all(18.0)),
              GestureDetector(
                child: Text("Camera"),
                onTap: (){
                  _openCamera(context);
                },
              ),
            ],
          ),
        ),
      );
    }
    );
  }

  Widget _decideImageView(){
    if(imageFile==null){
      return Text("No Image Selected");
    }
    else {
      return Image.file(imageFile,width:200,height: 200);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title:Text("Product details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          // height: response.setHeight(200),
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  height: 250,
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      _decideImageView(),
                      RaisedButton(
                        color: Colors.blue[400],
                        onPressed: (){
                          _showChoiceDialog(context);
                        },
                        child: Text("Select Image", style: TextStyle(color: Colors.white),),

                      ),
                    ],
                  ),
                ),
                Container(
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 10.0),
                        TextFormField(
                            onChanged: (val) {
                              setState(() => productName = val);
                            },
                            decoration: new InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 3.0),
                                // hintText: 'you@example.com',
                                labelText: 'Product Name'
                            )
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                            keyboardType: TextInputType.multiline,
                            onChanged: (val) {
                              setState(() => productDesc = val);
                            },
                            maxLines: null,
                            decoration: new InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical:3.0),
                                //hintText: 'you@example.com',
                                labelText: 'Product description'
                            )
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                            keyboardType: TextInputType.number,
                            onChanged: (val) {
                              setState(() => count = int.parse(val));
                            },
                            decoration: new InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 3.0),
                                // hintText: 'you@example.com',
                                labelText: 'Count'
                            )
                        ),
                        SizedBox(height: 10.0),
                        RaisedButton(
                            color: Colors.blue[400],
                            child: Text(
                              'Save Details',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              DatabaseService().updateProductData(url,productName,productDesc,count);
                            }
                        ),
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
}

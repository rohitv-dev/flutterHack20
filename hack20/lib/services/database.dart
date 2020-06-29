import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hack20/models/foodModel.dart';
import 'package:hack20/models/sharedModel.dart';
import 'package:hack20/models/userModel.dart';

class DatabaseService {
  final String uid;
  final String email;
  final String ngoName;

  DatabaseService({this.uid, this.email, this.ngoName});

  final CollectionReference _foodCollection = Firestore.instance.collection('food');
  final CollectionReference _counterCollection = Firestore.instance.collection('counter');
  final CollectionReference _usersNgosCollection = Firestore.instance.collection('usersNgos');

  Future setAddressData(String docName, String doorNo, String floorNo, String address, String city, String pinCode, double lat, double lon) async {
    return await _usersNgosCollection.document(uid).collection('address').document('address').setData({
      'name': docName,
      'doorNo': doorNo,
      'floorNo': floorNo,
      'addressLine': address,
      'city': city,
      'pinCode': pinCode,
      'latitude': lat,
      'longitude': lon,
    });
  }

  Future updateAddressData(String docName, String doorNo, String floorNo, String address, String city, String pinCode, double lat, double lon) async {
    return await _usersNgosCollection.document(uid).collection('address').document('address').updateData({
      'name': docName,
      'doorNo': doorNo,
      'floorNo': floorNo,
      'addressLine': address,
      'city': city,
      'pinCode': pinCode,
      'latitude': lat,
      'longitude': lon,
    });
  }

  Future setProfileData(String userName, String phoneNumber) async {
    return await _usersNgosCollection.document(uid).setData({
      'userName': userName,
      'phoneNumber': phoneNumber
    });
  }

  Future updateProfileData(String userName, String phoneNumber) async {
    return await _usersNgosCollection.document(uid).updateData({
      'userName': userName,
      'phoneNumber': phoneNumber
    });
  }


  UserNGOAddress _userAddressFromSnapshot(DocumentSnapshot snapshot) {
    return UserNGOAddress(
      name: snapshot.data['name'] ?? '',
      doorNo: snapshot.data['doorNo'] ?? '',
      floorNo: snapshot.data['floorNo'] ?? '',
      addressLine: snapshot.data['addressLine'] ?? '',
      city: snapshot.data['city'] ?? '',
      pinCode: snapshot.data['pincode'] ?? '',
      latitude: snapshot.data['latitude'] ?? 12.837605,
      longitude: snapshot.data['longitude'] ?? 80.205146,
    );
  }

  UserProfile _userProfileFromSnapshot(DocumentSnapshot snapshot) {
    return UserProfile(
      userName: snapshot.data['userName'],
      phoneNumber: snapshot.data['phoneNumber']
    );
  }

  Future updateFoodCount(int count) async {
    return await _counterCollection.document('foodId').setData({'count': count });
  }

  Future getFoodCount() async {
    return await _counterCollection.document('foodId').snapshots().first;
  }

  Future setFoodData(
      String id, String name, String email, double latitude, double longitude,
      int quantity, Timestamp notifiedTime, Timestamp bestBeforeTime,
      bool hasBeenPickedUp, String pickedBy, String imageUrl) async {
    return _foodCollection.document('food' + id.padLeft(4, '0')).setData({
      'id': id,
      'name': name,
      'email': email,
      'latitude': latitude,
      'longitude': longitude,
      'quantity': quantity,
      'notifiedTime': notifiedTime,
      'bestBeforeTime': bestBeforeTime,
      'hasBeenPickedUp': hasBeenPickedUp,
      'pickedBy': pickedBy,
      'imageUrl': imageUrl
    });
  }

  Future foodPickedUp(String id, bool hasBeenPickedUp, String pickedBy, Timestamp notifiedTime) async {
    return _foodCollection.document('food' + id.padLeft(4, '0')).updateData({
      'hasBeenPickedUp': hasBeenPickedUp,
      'pickedBy': pickedBy,
      'notifiedTime': notifiedTime
    });
  }

  List<Food> _foodListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Food(
          id: doc.data['id'] ?? '',
          name: doc.data['name'] ?? '',
          email: doc.data['email'] ?? '',
          latitude: doc.data['latitude'] ?? 12.837605,
          longitude: doc.data['longitude'] ?? 80.205146,
          quantity: doc.data['quantity'] ?? 0,
          notifiedTime: doc.data['notifiedTime'] ?? Timestamp.now(),
          bestBeforeTime: doc.data['bestBeforeTime'] ?? Timestamp.now(),
          hasBeenPickedUp: doc.data['hasBeenPickedUp'] ?? false,
          pickedBy: doc.data['pickedBy'] ?? '',
          imageUrl: doc.data['imageUrl'] ?? ''
      );
    }).toList();
  }

  Stream<List<Food>> get pendingFood {
    return _foodCollection.where('hasBeenPickedUp', isEqualTo: false).snapshots().map(_foodListFromSnapshot);
  }

  Stream<List<Food>> get userFoodHistory {
    return _foodCollection.where('email', isEqualTo: email).snapshots().map(_foodListFromSnapshot);
  }

  Stream<List<Food>> get ngoFoodHistory {
    return _foodCollection.where('pickedBy', isEqualTo: ngoName).snapshots().map(_foodListFromSnapshot);
  }

  Stream<UserNGOAddress> get userNgosAddressData {
    return _usersNgosCollection.document(uid).collection('address').document('address').snapshots().map(_userAddressFromSnapshot);
  }

  Stream<UserProfile> get userProfileData {
    return _usersNgosCollection.document(uid).snapshots().map(_userProfileFromSnapshot);
  }
}
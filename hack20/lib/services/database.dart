import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hack20/models/foodModel.dart';
import 'package:hack20/models/sharedModel.dart';
import 'package:hack20/models/userModel.dart';

class DatabaseService {
  final String uid;
  final String email;
  final String ngoName;

  DatabaseService({this.uid, this.email, this.ngoName});

  final CollectionReference _foodCollection =
      FirebaseFirestore.instance.collection('food');
  final CollectionReference _counterCollection =
      FirebaseFirestore.instance.collection('counter');
  final CollectionReference _usersNgosCollection =
      FirebaseFirestore.instance.collection('usersNgos');

  Future setAddressData(
      String docName,
      String doorNo,
      String floorNo,
      String address,
      String city,
      String pinCode,
      double lat,
      double lon) async {
    return await _usersNgosCollection
        .doc(uid)
        .collection('address')
        .doc('address')
        .set({
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

  Future updateAddressData(
      String docName,
      String doorNo,
      String floorNo,
      String address,
      String city,
      String pinCode,
      double lat,
      double lon) async {
    return await _usersNgosCollection
        .doc(uid)
        .collection('address')
        .doc('address')
        .update({
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
    return await _usersNgosCollection
        .doc(uid)
        .set({'userName': userName, 'phoneNumber': phoneNumber});
  }

  Future updateProfileData(String userName, String phoneNumber) async {
    return await _usersNgosCollection
        .doc(uid)
        .update({'userName': userName, 'phoneNumber': phoneNumber});
  }

  UserNGOAddress _userAddressFromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    return UserNGOAddress(
      name: data['name'] ?? '',
      doorNo: data['doorNo'] ?? '',
      floorNo: data['floorNo'] ?? '',
      addressLine: data['addressLine'] ?? '',
      city: data['city'] ?? '',
      pinCode: data['pincode'] ?? '',
      latitude: data['latitude'] ?? 12.837605,
      longitude: data['longitude'] ?? 80.205146,
    );
  }

  UserProfile _userProfileFromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    return UserProfile(
        userName: data['userName'], phoneNumber: data['phoneNumber']);
  }

  Future updateFoodCount(int count) async {
    return await _counterCollection.doc('foodId').set({'count': count});
  }

  Future getFoodCount() async {
    return await _counterCollection.doc('foodId').snapshots().first;
  }

  Future setFoodData(
      String id,
      String name,
      String email,
      double latitude,
      double longitude,
      int quantity,
      Timestamp notifiedTime,
      Timestamp bestBeforeTime,
      bool hasBeenPickedUp,
      String pickedBy,
      String imageUrl) async {
    return _foodCollection.doc('food' + id.padLeft(4, '0')).set({
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

  Future foodPickedUp(String id, bool hasBeenPickedUp, String pickedBy,
      Timestamp notifiedTime) async {
    return _foodCollection.doc('food' + id.padLeft(4, '0')).update({
      'hasBeenPickedUp': hasBeenPickedUp,
      'pickedBy': pickedBy,
      'notifiedTime': notifiedTime
    });
  }

  List<Food> _foodListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Map data = doc.data();
      return Food(
          id: data['id'] ?? '',
          name: data['name'] ?? '',
          email: data['email'] ?? '',
          latitude: data['latitude'] ?? 12.837605,
          longitude: data['longitude'] ?? 80.205146,
          quantity: data['quantity'] ?? 0,
          notifiedTime: data['notifiedTime'] ?? Timestamp.now(),
          bestBeforeTime: data['bestBeforeTime'] ?? Timestamp.now(),
          hasBeenPickedUp: data['hasBeenPickedUp'] ?? false,
          pickedBy: data['pickedBy'] ?? '',
          imageUrl: data['imageUrl'] ?? '');
    }).toList();
  }

  Stream<List<Food>> get pendingFood {
    return _foodCollection
        .where('hasBeenPickedUp', isEqualTo: false)
        .snapshots()
        .map(_foodListFromSnapshot);
  }

  Stream<List<Food>> get userFoodHistory {
    return _foodCollection
        .where('email', isEqualTo: email)
        .snapshots()
        .map(_foodListFromSnapshot);
  }

  Stream<List<Food>> get ngoFoodHistory {
    return _foodCollection
        .where('pickedBy', isEqualTo: ngoName)
        .snapshots()
        .map(_foodListFromSnapshot);
  }

  Stream<UserNGOAddress> get userNgosAddressData {
    return _usersNgosCollection
        .doc(uid)
        .collection('address')
        .doc('address')
        .snapshots()
        .map(_userAddressFromSnapshot);
  }

  Stream<UserProfile> get userProfileData {
    return _usersNgosCollection
        .doc(uid)
        .snapshots()
        .map(_userProfileFromSnapshot);
  }
}

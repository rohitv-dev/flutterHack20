import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hack20/models/foodModel.dart';

class DatabaseService {
  final String email;
  final String ngoName;

  DatabaseService({this.email, this.ngoName});

  final CollectionReference _foodCollection = Firestore.instance.collection('food');
  final CollectionReference _counterCollection = Firestore.instance.collection('counter');

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
}
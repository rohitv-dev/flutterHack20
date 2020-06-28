import 'package:cloud_firestore/cloud_firestore.dart';

class Food {
  final String id;
  final String name;
  final String email;
  final double latitude;
  final double longitude;
  final int quantity;
  final Timestamp notifiedTime;
  final Timestamp bestBeforeTime;
  final bool isReady;
  final bool hasBeenPickedUp;
  final String pickedBy;
  final String imageUrl;

  Food({
    this.id,
    this.name,
    this.email,
    this.latitude,
    this.longitude,
    this.quantity,
    this.notifiedTime,
    this.bestBeforeTime,
    this.isReady,
    this.hasBeenPickedUp,
    this.pickedBy,
    this.imageUrl
  });
}
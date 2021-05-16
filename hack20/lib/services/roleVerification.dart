import 'package:cloud_firestore/cloud_firestore.dart';

class AccountVerification {
  Future<void> addSingleRole(String email, String role) async {
    await FirebaseFirestore.instance.collection('Roles').doc(email).set({
      'role': role,
    });
  }

  Future<String> checkRole(String email) async {
    DocumentSnapshot Data =
        await FirebaseFirestore.instance.collection('Roles').doc(email).get();
    Map roleData = Data.data();
    if (roleData.isNotEmpty) {
      if (roleData['role'] == 'NGO') {
        return 'ngoaccess';
      } else {
        return 'useraccess';
      }
    } else {
      return 'error';
    }
  }
}

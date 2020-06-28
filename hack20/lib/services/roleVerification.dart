import 'package:cloud_firestore/cloud_firestore.dart';

class AccountVerification {
  Future<void> addSingleRole(String email, String role) async {
    await Firestore.instance.collection('Roles').document(email).setData({
      'role': [role],
    });
  }

  Future<String> checkRole(String email) async {
    DocumentSnapshot roleData =
        await Firestore.instance.collection('Roles').document(email).get();
    if (roleData.exists) {
      final Map<String, dynamic> map = roleData.data;
      var roleList = map['role'];
      if (roleList.contains('NGO')) {
        return 'ngoaccess';
      } else {
        return 'useraccess';
      }
    } else {
      return 'error';
    }
  }
}

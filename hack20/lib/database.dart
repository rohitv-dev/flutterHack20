import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference productCollection = Firestore.instance.collection('product');

  Future<void> updateProductData(String url, String productName,String productDesc,int count) async {
    return await productCollection.document(uid).updateData({'url': url,'productName': productName,'productDesc':productDesc,'count':count  });
  }

}
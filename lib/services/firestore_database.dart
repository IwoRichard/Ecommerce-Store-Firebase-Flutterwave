// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future UserInfo(String email, String name, String address, String userId)async{
    try {
      await firestore.collection('userInfo').add({
        "email": email,
        "name": name,
        "address": address,
        "date": DateTime.now(),
        "userId": userId
      });
    } catch (e) {
      print(e);
    }
  }

  Future updateUserInfo(String docId,String name, String address)async{
    try {
      await firestore.collection('notes').doc(docId).update({
        "name":name,
        "address": address,
      });
    } catch (e) {
      print(e);
    }
  }

}
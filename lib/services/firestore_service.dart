// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //Add User Info
  Future insertUserInfo(String name, String address, String userId)async{
    try {
      await firestore.collection('users').add({
        "name": name,
        "address": address,
        "date": DateTime.now(),
        "userId": userId
      });
    } catch (e) {
      print(e);
    }
  }

  //Edit User Info
  Future updateUserInfo(String docId, String name, String address)async{
    try {
      await firestore.collection('users').doc(docId).update({
        "name": name,
        "address": address,
      });
    } catch (e) {
      print(e);
    }
  }

}
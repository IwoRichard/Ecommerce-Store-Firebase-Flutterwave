// ignore_for_file: avoid_print, non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService{
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //To get/store user informations
  Future UserInfo(String email, String name, String address)async{
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      final _uid = user!.uid;
      await firestore.collection('userInfo').doc(_uid).set({
        "email": email,
        "name": name,
        "address": address,
        "date": DateTime.now(),
        "userId": _uid,
      });
    } catch (e) {
      print(e);
    }
  }

  //To update user address
    Future updateUserAddress(String address)async{
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      final _uid = user!.uid;
      await firestore.collection('userInfo').doc(_uid).update({
        "address": address,
      });
    } catch (e) {
      print(e);
    }
  }

  //To update username
    Future updateUserName(String name)async{
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      final _uid = user!.uid;
      await firestore.collection('userInfo').doc(_uid).update({
        "name":name,
      });
    } catch (e) {
      print(e);
    }
  } 
}
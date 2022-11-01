// ignore_for_file: avoid_print, body_might_complete_normally_nullable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService{
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //Register User
  Future <User?> register(String email, String password,BuildContext context)async{
    try {
     UserCredential userCredential =  await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password,);
    return userCredential.user; 
    } on FirebaseAuthException catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString()),backgroundColor: Colors.red,));
    }
    catch (e) {
      print(e.toString());
    }
  }

  //Login
  Future <User?> login(String email, String password,BuildContext context)async{
    try {
    UserCredential userCredential =  await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;  
    } on FirebaseAuthException catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString()),backgroundColor: Colors.red,));
    }
    catch (e) {
      print(e.toString());
    }
    
  }

  //SignOut
  Future<User?> signout()async{
    await GoogleSignIn().signOut();
    await firebaseAuth.signOut();
  }

  //Google Sign
  Future<User?> googleSignIn()async{
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if(googleUser != null){
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken
        );
        UserCredential userCredential = await firebaseAuth.signInWithCredential(credential);
        if (userCredential.additionalUserInfo!.isNewUser) {
          await firestore.collection('userInfo').doc(userCredential.user!.uid).set({
            "email": userCredential.user!.email,
            "name": userCredential.user!.displayName,
            "address": '',
            "date": DateTime.now(),
            "userId": userCredential.user!.uid
          });
        }
        return userCredential.user;
      }
    } catch (e) {
      print(e);
    }
  }

}
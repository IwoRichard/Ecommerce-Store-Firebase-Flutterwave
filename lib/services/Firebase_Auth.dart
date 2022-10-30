// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class AuthService{
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  

  //Register User
  Future <User?> registerUser(String email, String password, BuildContext context)async{
    try {
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString()),backgroundColor: Colors.red,));
    }
    catch(e){
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
}
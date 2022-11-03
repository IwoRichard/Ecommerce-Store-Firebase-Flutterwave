// ignore_for_file: prefer_const_constructors, avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  
  String? name = '';
  String? address = '';
  String? email = '';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('userInfo').doc(user!.uid).get().then((snapshot) async {
          if (snapshot.exists) {
            setState(() {
              name = snapshot.data()!['name'];
              address = snapshot.data()!['address'];
              email = snapshot.data()!['email'];
            });
          }
        }).asStream(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name?? ''
                ),
                Text(
                  email?? ''
                ),
                Text(
                  address ?? ''
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
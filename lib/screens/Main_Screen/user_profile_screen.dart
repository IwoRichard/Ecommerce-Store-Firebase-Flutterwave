// ignore_for_file: prefer_const_constructors, avoid_print
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {

  final TextEditingController _addressController = TextEditingController(text: '');

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  String? email;
  String? name;
  String? address;
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    getuserInfo();
    super.initState();
  }

  Future<void> getuserInfo()async{
    setState(() {});
    if (user == null) {
      setState(() {});
      return;
    }
    try {
      String _uid = user!.uid;
      final DocumentSnapshot userDoc = 
        await FirebaseFirestore.instance.collection('userInfo').doc(_uid).get();
      if (userDoc == null) {
        return;
      } else{
        email = userDoc.get('email');
        name = userDoc.get('name');
        address = userDoc.get('address');
      }
    } catch (error) {
      setState(() {});
      print(error);
    }finally{
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              email??''
            ),
            Text(
              name??''
            ),
            Text(
              address??''
            ),
          ],
        )
      ),
    );
  }
}
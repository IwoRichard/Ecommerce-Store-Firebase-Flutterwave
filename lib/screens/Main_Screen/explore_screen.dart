// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../services/firebase_auth.dart';
import '../Auth_Screen/login_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        actions: [
          TextButton.icon(
            onPressed: ()async{
              await FirebaseAuthService().signout();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
            }, 
            icon: const Icon(Icons.logout), 
            label: const Text('Sign out'),
            style: TextButton.styleFrom(foregroundColor: Colors.white),
          )
        ],
      ),
      body: Center(child: Text('Explore'),),
    );
  }
}
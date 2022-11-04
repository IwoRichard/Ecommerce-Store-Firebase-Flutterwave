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
        backgroundColor: Colors.white,
        elevation: .5,
        title: Text('Explore',style: TextStyle(fontSize: 34,fontWeight: FontWeight.w600,color: Colors.black),),
      ),
      body: Center(child: Text('Explore'),),
    );
  }
}
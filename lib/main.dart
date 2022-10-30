// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shop/screens/home_page.dart';
import 'package:shop/screens/signUp_page.dart';
import '../services/Firebase_Auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: StreamBuilder(
        stream: AuthService().firebaseAuth.authStateChanges(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          }
          return RegisterScreen(user: snapshot.data);
        }
      ),
    );
  }
}
// ignore_for_file: prefer_const_constructors
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart_provider.dart';
import 'package:shop/screens/Auth_Screen/default_home_screen.dart';
import 'package:shop/services/firebase_auth.dart';
import 'package:shop/widgets/bottom_nav.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: StreamBuilder(
          stream: FirebaseAuthService().firebaseAuth.authStateChanges(),
          builder: (context,AsyncSnapshot snapshot){
            if (snapshot.hasData) {
              return BottomNav();
            }
            return DefaultHome();
          }
        ),
      ),
    );
  }
}
// ignore_for_file: prefer_const_constructors, avoid_print,  prefer_const_literals_to_create_immutables, use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../services/firebase_auth.dart';
import '../Auth_Screen/login_screen.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  
  String name = '';
  String address = '';
  String email = '';
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: .5,
        title: Text('My Account',style: TextStyle(fontSize: 34,fontWeight: FontWeight.w600,color: Colors.black),),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('userInfo').doc(user?.uid).get().then((snapshot) async {
          if (snapshot.exists) {
            setState(() {
              name = snapshot.data()!['name'];
              address = snapshot.data()!['address'];
              email = snapshot.data()!['email'];
            });
          }
        }).asStream(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('User Details',style: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey,)),
                  SizedBox(height: 10,),
                  Container(
                    color: Colors.grey.withOpacity(.1),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text('Display Name',style: TextStyle(fontWeight: FontWeight.w600),),
                          subtitle: Text(name),
                          trailing: Chip(label: Text('Edit')),
                        ),
                        Divider(height: 0,),
                        ListTile(
                          title: Text('Email Address',style: TextStyle(fontWeight: FontWeight.w600),),
                          subtitle: Text(email),
                        ),
                        Divider(height: 0,),
                        ListTile(
                          title: Text('Delivery Address',style: TextStyle(fontWeight: FontWeight.w600),),
                          subtitle: Text(address),
                          trailing: GestureDetector(
                            onTap: (){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(address)));
                            },
                            child: Chip(label: Text('Edit'))),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text('Security Settings',style: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey,)),
                  SizedBox(height: 10,),
                  Container(
                    color: Colors.grey.withOpacity(.1),
                    child: ListTile(
                      title: Text('Password Reset',style: TextStyle(fontWeight: FontWeight.w600),),
                      subtitle: Text('***********'),
                      trailing: Chip(label: Text('Edit')),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text('Others',style: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey,)),
                  SizedBox(height: 10,),
                  Container(
                    color: Colors.grey.withOpacity(.1),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text('Notifications',style: TextStyle(fontWeight: FontWeight.w600),),
                        ),
                        Divider(height: 0,),
                        ListTile(
                          title: Text('Support',style: TextStyle(fontWeight: FontWeight.w600),),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextButton.icon(
                    onPressed: ()async{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sign Out?'),
                      duration: Duration(seconds: 5),
                      backgroundColor: Colors.red,
                      action: SnackBarAction(
                        textColor: Colors.white,
                        label: 'Yes',
                        onPressed: ()async{
                        await FirebaseAuthService().signout();
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
                      }),));
                    }, 
                    icon: const Icon(Icons.logout), 
                    label: const Text('Sign out',),
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
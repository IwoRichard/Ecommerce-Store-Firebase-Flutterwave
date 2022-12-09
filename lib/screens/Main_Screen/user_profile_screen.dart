import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shop/widgets/user_list_Tile.dart';
import '../../services/firebase_auth.dart';
import '../Auth_Screen/forgot_password_screen.dart';
import '../Auth_Screen/login_screen.dart';


class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  TextEditingController addressController = TextEditingController(text: '');
  TextEditingController nameController = TextEditingController(text: '');
  
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
        title: const Text('My Account',style: TextStyle(fontSize: 34,fontWeight: FontWeight.w600,color: Colors.black),),
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
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  tileTile('User Details'),
                  const SizedBox(height: 10,),
                  UserTile(
                    title: 'Display Name',
                    subtitle: name,
                    nameController: nameController,
                    trailing: 'Edit',
                  ),
                  UserTile(
                    title: 'Email',
                    subtitle: email,
                  ),
                  UserTile(
                    title: 'Delivery Address',
                    subtitle: address == '' ? 'add adress': address,
                    addressController: addressController,
                    trailing: 'Edit',
                  ),
                  const SizedBox(height: 10,),
                  tileTile('Security Settings'),
                  const SizedBox(height: 10,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                          context, 
                          PageTransition(
                            child: const ForgotPasswordScreen(), 
                            type: PageTransitionType.rightToLeft,
                            duration: const Duration(milliseconds: 300)
                          ),
                      );
                    },
                    child: UserTile(
                      title: 'Reset Password',
                    ),
                  ),
                  const SizedBox(height: 10,),
                  tileTile('Others'),
                  const SizedBox(height: 10,),
                  UserTile(
                    title: 'Notification',
                  ),
                  UserTile(
                    title: 'Support',
                  ),
                  const SizedBox(height: 10,),
                  TextButton.icon(
                    onPressed: ()async{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text('Sign Out?'),
                      duration: const Duration(seconds: 5),
                      backgroundColor: Colors.red,
                      action: SnackBarAction(
                        textColor: Colors.white,
                        label: 'Yes',
                        onPressed: ()async{
                        await FirebaseAuthService().signout();
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);
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
  Widget tileTile(String title){
    return Text(title);
  }
}
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:shop/screens/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Create an account',
                  style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w600,color: Colors.black,
                  ),
                ),
                Text(
                  'Discover your fashion',
                ),
                SizedBox(height: 30,),
                Text(
                  'Name',
                  style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 5),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.01),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextFormField(
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      hintText: 'Ross Geller',
                      hintStyle: TextStyle(fontSize: 15,color: Colors.grey),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.only(left: 10),
                      filled: true
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  'Email',
                  style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 5),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.01),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextFormField(
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      hintText: 'example@gmail.com',
                      hintStyle: TextStyle(fontSize: 15,color: Colors.grey),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.only(left: 10),
                      filled: true
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  'Password',
                  style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 5),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.01),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextFormField(
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      hintText: 'password123',
                      hintStyle: TextStyle(fontSize: 15,color: Colors.grey),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.only(left: 10),
                      filled: true
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  'Address',
                  style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 5),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.01),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextFormField(
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      hintText: 'surulere, Lagos',
                      hintStyle: TextStyle(fontSize: 15,color: Colors.grey),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.only(left: 10),
                      filled: true
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.2,color: Colors.transparent),
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: MaterialButton(
                    onPressed: (){},
                    child: Text(
                      'SignUp',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17,color:Colors.white)
                    ),
                  )
                ),
                SizedBox(height: 10,),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        )
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(color: Colors.black)
                          ),
                          TextSpan(
                            text: 'Login',
                            style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600)
                          ),
                        ]
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
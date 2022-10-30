// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:shop/screens/forgot_password_screen.dart';
import 'package:shop/screens/sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                  'Welcome ☺️',
                  style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w600,color: Colors.black,
                  ),
                ),
                Text(
                  'Sign in to continue',
                ),
                SizedBox(height: 30,),
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
                      hintText: 'password',
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
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: (){
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => ForgotPasswordScreen(),
                        )
                      );
                    },
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600),
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
                      'Login',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17,color:Colors.white)
                    ),
                  )
                ),
                SizedBox(height: 20,),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap:(){
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(), 
                        )
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(color: Colors.black)
                          ),
                          TextSpan(
                            text: 'Sign Up',
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
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:page_transition/page_transition.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  bool obscureText = true;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formKey,
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
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      cursorColor: Colors.grey,
                      decoration: textfieldDecoration(),
                      validator: (value) {
                        if (value!.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(behavior: SnackBarBehavior.floating,content: Text('Enter Name'),backgroundColor: Colors.red,duration: Duration(seconds: 3),));
                        }else{
                          return null;
                        }
                      },
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
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.grey,
                      decoration: textfieldDecoration().copyWith(
                        hintText: 'example@gmail.com'
                      ),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(behavior: SnackBarBehavior.floating,content: Text('Enter valid Email Address'),backgroundColor: Colors.red,duration: Duration(seconds: 3),));
                        }else{
                          return null;
                        }
                      },
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
                      textInputAction: TextInputAction.next,
                      cursorColor: Colors.grey,
                      obscureText: obscureText,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: (){
                            setState(() {
                              obscureText = !obscureText;
                            });
                          }, 
                          icon: obscureText ? 
                          Icon(Icons.visibility, color: Colors.grey,) : 
                          Icon(Icons.visibility_off, color: Colors.grey,)
                        ),
                        hintText: 'password123',
                        hintStyle: TextStyle(fontSize: 15,color: Colors.grey),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.only(left: 10),
                        filled: true
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 7) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(behavior: SnackBarBehavior.floating,content: Text('Password should be at least 7 characters'),backgroundColor: Colors.red,duration: Duration(seconds: 3),));
                        }else{
                          return null;
                        }
                      },
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
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.grey,
                      decoration: textfieldDecoration().copyWith(
                        hintText: '09, Unity crescent, off Gasline, Ogun State'
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 7) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(behavior: SnackBarBehavior.floating,content: Text('Address should be a least 7 characters'),backgroundColor: Colors.red,duration: Duration(seconds: 3),));
                        }else{
                          return null;
                        }
                      },
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
                      onPressed: (){
                        final isvalid = formKey.currentState!.validate();
                        FocusScope.of(context).unfocus();
                        if (isvalid) {
                          
                        }
                      },
                      child: Text(
                        'SignUp',
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17,color:Colors.white)
                      ),
                    )
                  ),
                  SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.center,
                    child: SignInButton(
                      Buttons.Google,
                      text: 'Sign up with Google',
                      elevation: 0.5,
                      onPressed: (){}
                    ),
                  ),
                  SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context, 
                          PageTransition(
                            child: LoginScreen(), 
                            type: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 300)
                          ),
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
      ),
    );
  }

InputDecoration textfieldDecoration() {
    return InputDecoration(
      hintText: 'Ross Geller',
      hintStyle: TextStyle(fontSize: 15,color: Colors.grey),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
      contentPadding: EdgeInsets.only(left: 10),
      filled: true
    );
  }
}
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shop/screens/Auth_Screen/sign_up_screen.dart';
import 'package:shop/screens/Auth_Screen/forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}   
class _LoginScreenState extends State<LoginScreen> {

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
                    'Welcome back 😁',
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
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
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
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(behavior: SnackBarBehavior.floating,content: Text('Enter Valid Email Address'),backgroundColor: Colors.red,duration: Duration(seconds: 3),));   
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
                      textInputAction: TextInputAction.done,
                      obscureText: obscureText,
                      cursorColor: Colors.grey,
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
                        hintText: 'password',
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
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: (){
                        Navigator.push(
                          context, 
                          PageTransition(
                            child: ForgotPasswordScreen(), 
                            type: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 300)
                          ),
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
                      onPressed: (){
                        final isvalid = formKey.currentState!.validate();
                        FocusScope.of(context).unfocus();
                        if (isvalid) {
                          formKey.currentState!.save();
                        }
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17,color:Colors.white)
                      ),
                    )
                  ),
                  SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.center,
                    child: SignInButton(
                      Buttons.Google,
                      elevation: 0.5,
                      onPressed: (){}
                    ),
                  ),
                  SizedBox(height: 20,),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap:(){
                        Navigator.push(
                          context, 
                          PageTransition(
                            child: SignUpScreen(), 
                            type: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 300)
                          ),
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
      ),
    );
  }
}
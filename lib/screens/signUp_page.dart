//FirebaseFirestore firestore = FirebaseFirestore.instance;

// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print, sized_box_for_whitespace

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/Firebase_Auth.dart';
import '../services/firestore_service.dart';
import 'home_page.dart';

class RegisterScreen extends StatefulWidget {
  User user;
  RegisterScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 30,),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 30,),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 30,),
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: 'address',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 30,),
              loading ? CircularProgressIndicator(): Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: ()async{
                    setState(() {
                      loading = true;
                    });
                    if (emailController.text.isEmpty || passwordController.text.isEmpty || nameController.text.isEmpty || addressController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('All fields are required!'),backgroundColor: Colors.red,));                    
                    } else{
                      User? result = 
                      await AuthService().registerUser(emailController.text, passwordController.text,context);
                      await FirestoreService().insertUserInfo(nameController.text, addressController.text, widget.user.uid);
                      if (result != null) {
                        print('Success!');
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()),);
                      }
                    }
                    setState(() {
                      loading = false;
                    });
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ),
              ),
              // SizedBox(height: 20,),
              // TextButton(
              //   onPressed: (){
              //     Navigator.push(
              //       context, 
              //       MaterialPageRoute(
              //         builder: (context) => LoginScreen()
              //       )
              //     );
              //   }, 
              //   child: Text('Already have an account? Login Here')
              // ),
              // SizedBox(height: 10,),
              // loading? CircularProgressIndicator(): SignInButton(
              //   onPressed: ()async{
              //     setState(() {
              //       loading = true;
              //     });
              //     await AuthService().googleSignIn();
              //     setState(() {
              //       loading = false;
              //     });
              //   },
              //   Buttons.Google,
              //   text: 'Continue with Google', 
              // )
            ],
          ),
        ),
      ),
    );
  }
}
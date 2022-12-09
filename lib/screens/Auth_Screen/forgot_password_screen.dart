import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          }, 
          icon: const Icon(Icons.arrow_back_ios_new_rounded,color: Colors.black,)
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter your email address',
                style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w600,color: Colors.black,
                ),
              ),
              const Text(
                'A new password will be sent to your email address.',
              ),
              const SizedBox(height: 30,),
              const Text(
                'Email',
                style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 5),
              Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.01),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  controller: emailController,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.grey,
                  decoration: const InputDecoration(
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
              const SizedBox(height: 20,),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(width: 1.2,color: Colors.transparent),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: MaterialButton(
                  color: Colors.black87,
                  disabledColor: Colors.grey.withOpacity(.5),
                  disabledTextColor: Colors.black.withOpacity(.5),
                  onPressed: isLoading ? null : ()async{
                    setState(() {isLoading = true;});
                    if (emailController.text.isEmpty || !emailController.text.contains('@')) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Text('Enter Valid Email Address'),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 3),
                        )
                      );
                    }else{
                      await resetPassword();
                    }
                    setState(() {
                      isLoading = false;
                    });
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17,color:Colors.white)
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
  //Rest password function
  Future resetPassword()async{
    try {
      await FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Password Reset Email Sent'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        )
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(e.message.toString()),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
        )
      );

    }
  }
}
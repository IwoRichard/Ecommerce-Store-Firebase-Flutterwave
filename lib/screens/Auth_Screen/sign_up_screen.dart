import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shop/services/firestore_user_database.dart';
import '../../services/firebase_auth.dart';
import '../../widgets/bottom_nav.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  bool isLoading = false;
  bool obscureText = true;
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();

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
                  const Text(
                    'Create an account',
                    style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600,color: Colors.black,
                    ),
                  ),
                  const Text(
                    'Discover your fashion',
                  ),
                  const SizedBox(height: 30,),
                  const Text(
                    'Name',
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
                      controller: nameController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      cursorColor: Colors.grey,
                      decoration: textfieldDecoration(),
                      validator: validateName,
                    ),
                  ),
                  const SizedBox(height: 10,),
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
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.grey,
                      decoration: textfieldDecoration().copyWith(
                        hintText: 'example@gmail.com'
                      ),
                      validator: validateEmail
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Text(
                    'Password',
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
                      controller: passwordController,
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
                          const Icon(Icons.visibility, color: Colors.grey,) : 
                          const Icon(Icons.visibility_off, color: Colors.grey,)
                        ),
                        hintText: 'password123',
                        hintStyle: const TextStyle(fontSize: 15,color: Colors.grey),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.only(left: 10),
                        filled: true
                      ),
                      validator: validatePassword
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Text(
                    'Address',
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
                      controller: addressController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.grey,
                      decoration: textfieldDecoration().copyWith(
                        hintText: '09, Unity crescent, off Gasline, Ogun State'
                      ),
                      validator: validateAddress
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
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black.withOpacity(.5),
                      onPressed: isLoading ? null : ()async{
                        setState(() {isLoading = true;});
                        final isvalid = formKey.currentState!.validate();
                        FocusScope.of(context).unfocus();
                        if (isvalid) {
                          User? result = 
                          await FirebaseAuthService().register(emailController.text, passwordController.text, context);
                          await FirestoreService().UserInfo(emailController.text, nameController.text, addressController.text);
                          if (result != null) {
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const BottomNav()), (route) => false);
                          }
                        }
                        setState(() {isLoading = false;});
                      },
                      child: const Text(
                        'SignUp',
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17,color:Colors.white)
                      ),
                    )
                  ),
                  const SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.center,
                    child: SignInButton(
                      Buttons.GoogleDark,
                      text: 'Sign up with Google',
                      elevation: 0.5,
                      onPressed: ()async{
                        await FirebaseAuthService().googleSignIn();
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const BottomNav()), (route) => false);
                      }
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context, 
                          PageTransition(
                            child: const LoginScreen(), 
                            type: PageTransitionType.rightToLeft,
                            duration: const Duration(milliseconds: 300)
                          ),
                        );
                      },
                      child: RichText(
                        text: const TextSpan(
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
    return const InputDecoration(
      hintText: 'Ross Geller',
      hintStyle: TextStyle(fontSize: 15,color: Colors.grey),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
      contentPadding: EdgeInsets.only(left: 10),
      filled: true
    );
  }

//To validate name
String? validateName(String? formName){
  if (formName!.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text('Enter Name'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        )
      );
  }else{
    return null;
  }
  return null;
}

//To validate email
  String? validateEmail(String? formEmail){
    String pattern = r'\w+@\w+\.\w+';
    RegExp regExp = RegExp(pattern);
    if (formEmail!.isEmpty || formEmail == null || !regExp.hasMatch(formEmail)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Enter Valid Email Address'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
          )
        );   
    }else{
      return null;
    }
    return null;
  }

  //To validate password
  String? validatePassword(String? formPassword){
    if (formPassword!.isEmpty || formPassword == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Enter Password'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 6),
        )
      );
    }else{
      return null;
    }
    return null;
  }

  //To validate address
  String? validateAddress(String? formAddress){
    if (formAddress!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Enter Delivery Address'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
          )
        );
    }else{
      return null;
    }
    return null;
  }

}
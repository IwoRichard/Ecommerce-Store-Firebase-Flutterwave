import 'package:flutter/material.dart';
import 'package:shop/screens/Auth_Screen/sign_up_screen.dart';
import 'login_screen.dart';

class DefaultHome extends StatelessWidget {
  const DefaultHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/shop.jpg'),
            fit: BoxFit.cover
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(.8),
                Colors.black.withOpacity(.3),
              ]
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end, 
              children: [
                const Text(
                  'Find your\nFashion',
                  style: TextStyle(color: Colors.white,fontSize: 45,fontWeight: FontWeight.w700),
                ),
                const Text(
                  'The perfect outfit to accenuate your style.',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 40,),
                Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  child: MaterialButton(
                    onPressed: (){
                      Navigator.pushAndRemoveUntil(
                        context, 
                        MaterialPageRoute(builder: (context) => const LoginScreen()), 
                        (route) => false
                      );
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18,color:Colors.white)
                    ),
                  )
                ),
                const SizedBox(height: 20,),
                Container(
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey,width: 1.5),
                    ),
                    child: MaterialButton(
                      onPressed: (){
                        Navigator.pushAndRemoveUntil(
                          context, 
                          MaterialPageRoute(builder: (context) => const SignUpScreen()), 
                          (route) => false
                        );
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18,color:Colors.white),
                      )
                    ),
                  ),
              ],
            ),
          )
        ),
      ),
    );
  }
}
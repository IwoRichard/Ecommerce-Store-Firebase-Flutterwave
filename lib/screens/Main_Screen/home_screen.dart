import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop/screens/Secondary_Screen/category_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  String name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: .5,
        title: const Text('Home',style: TextStyle(fontSize: 34,fontWeight: FontWeight.w600,color: Colors.black),),
        actions: [
          Chip(
            backgroundColor: const Color.fromARGB(246, 7, 212, 92),
            label: displayName(),
          ),
          const SizedBox(width: 15,)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('categories').snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator(),);
            }
            return GridView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: .7
              ),
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data.docs[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return CategoryScreen(
                        collection: data['categoryName'], 
                        id: data.id,
                      );
                    }));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(data['categoryImage']),
                        fit: BoxFit.cover
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(.8),
                            Colors.black.withOpacity(.3),
                          ]
                        ),
                      ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15,bottom: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['categoryName'],
                            style: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      )
    );
  }
  //To display the current logged in username in homepage
StreamBuilder<void> displayName() {
  return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('userInfo').doc(user?.uid).get().then((snapshot) async {
        if (snapshot.exists) {
          setState(() {
            name = snapshot.data()!['name'];
          });
        }
      }).asStream(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Text(name);
      },
    );
  }
}
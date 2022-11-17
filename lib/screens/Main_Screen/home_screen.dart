// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables,use_build_context_synchronously

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
        title: Text('Home',style: TextStyle(fontSize: 34,fontWeight: FontWeight.w600,color: Colors.black),),
        actions: [
          Chip(
            backgroundColor: Color.fromARGB(246, 7, 212, 92),
            label: displayName(),
          ),
          SizedBox(width: 15,)
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(55),
          child: Padding(
            padding: EdgeInsets.only(left: 15,right: 15,bottom: 5),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.05),
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextFormField(
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  hintText: 'Search, shoes, watch . . .',
                  hintStyle: Theme.of(context).textTheme.headline2?.copyWith(fontSize: 15,color: Colors.grey),
                  prefixIcon: IconButton(
                    onPressed: (){}, 
                    icon: Icon(Icons.search_rounded,color: Colors.grey,)
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.zero,
                  filled: true
                ),
                onFieldSubmitted: (value){},
              ),
            ),
          ) 
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('categories').snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator(),);
            }
            return GridView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: .7
              ),
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return CategoryScreen(
                        collection: snapshot.data.docs[index]['categoryName'], 
                        id: snapshot.data.docs[index].id,
                      );
                    }));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(image: NetworkImage(snapshot.data.docs[index]['categoryImage']),fit: BoxFit.cover),
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
                            snapshot.data.docs[index]['categoryName'],
                            style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '${snapshot.data.docs[index]['categoryName'].length.toString()} Product',
                            style: TextStyle(color: Colors.white.withOpacity(.5)),
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
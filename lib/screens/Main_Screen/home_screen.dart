// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables,use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/chip_model.dart';
import 'package:shop/models/products_model.dart';
import 'package:shop/providers/products_provider.dart';
import 'package:shop/widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final User? user = FirebaseAuth.instance.currentUser;

  List<CategoryChip> choiceChips = chips;

  int current = 0;

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
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(
              height: 60,
              width: double.infinity,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: choiceChips.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                  return GestureDetector(
                    onTap: (){
                      setState(() {
                        current = index;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 5),
                      child: Chip(
                        backgroundColor: current == index ? Colors.black87 : Colors.grey.withOpacity(.5),
                        avatar: CircleAvatar(
                          foregroundImage: AssetImage(choiceChips[index].image),
                          backgroundColor: Colors.white,),
                        label: Text(
                          choiceChips[index].name,
                          style: TextStyle(color: current == index ? Colors.white : Colors.black.withOpacity(.5)),
                        )
                      ),
                    ),
                  );
                }
              ),
            ),
            Expanded(
              child: Text(
                choiceChips[current].name,
                style: TextStyle(fontSize: 50),
              )
            )
          ],
        ),
      )
    );
  }

StreamBuilder<Null> displayName() {
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
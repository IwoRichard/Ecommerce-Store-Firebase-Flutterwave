// ignore_for_file: prefer_const_constructors,  prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../widgets/cart_product_card.dart';
import '../Main_Screen/cart_screen.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
              Navigator.pop(context);
          }, 
          icon: Icon(Icons.arrow_back_ios_new_rounded,color: Colors.black,)
        ),
        elevation: .5,
        title: Text('CheckOut',style: TextStyle(fontSize: 34,fontWeight: FontWeight.w600,color: Colors.black),),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
          .collection('cart')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('userCart')
          .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator(),);
          }
          return snapshot.data!.docs.isEmpty? 
          Center(
            child: Text('Nothing in Cart'),
          ): Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.docs[index];
                    return CartCard(
                      productId: data['productId'], 
                      productImage: data['productImage'], 
                      productName: data['productName'], 
                      productQuantity: data['productQuantity'], 
                      productPrice: data['productPrice'],
                    );
                  }
                )
              ),
              ListTile(
                leading: Text('Sub Total'),
                trailing: Text('\$500'),
              ),
              ListTile(
                leading: Text('Shipping'),
                trailing: Text('\$500'),
              ),
              Divider(),
              ListTile(
                leading: Text('Total'),
                trailing: Text('\$500'),
              ),
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
                  onPressed:(){},
                  child: Text(
                    'Purchase',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17,color:Colors.white)
                  ),
                )
              ),
            ],
          )
        );
        }
      )
    );
  }
}
// ignore_for_file: prefer_const_constructors,  prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../widgets/cart_product_card.dart';
import '../Secondary_Screen/checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: .5,
        title: Text('My Cart',style: TextStyle(fontSize: 34,fontWeight: FontWeight.w600,color: Colors.black),),
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
                  onPressed:(){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=> CheckOutScreen())
                    );
                  },
                  child: Text(
                    'CheckOut',
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
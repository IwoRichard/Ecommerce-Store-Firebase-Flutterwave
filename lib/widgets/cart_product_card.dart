// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class CartCard extends StatefulWidget {
  final String productImage;
  final String productName;
  final double productPrice;
  final String productId;
  final int productQuantity;
  const CartCard({
    Key? key,
    required this.productImage,
    required this.productName,
    required this.productPrice,
    required this.productId,
    required this.productQuantity,
  }) : super(key: key);

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {

  //Function to delete a particular product from cart
  void productDelete(){
    FirebaseFirestore.instance
      .collection('cart')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('userCart')
      .doc(widget.productId)
      .delete();
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(widget.productImage),fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        SizedBox(width: 15,),
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    widget.productName,
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: (){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Delete Product'),
                      backgroundColor: Colors.red,
                      action: SnackBarAction(
                        textColor: Colors.white,
                        onPressed: () {
                          productDelete();
                        },
                        label: 'Yes',
                        ),
                      ));
                    }, 
                    icon: Icon(Icons.close)
                  )
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Text(
                    '\$${widget.productPrice}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 19,fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'quantity: ${widget.productQuantity}',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    )
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
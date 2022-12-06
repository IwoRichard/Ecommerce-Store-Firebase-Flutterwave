// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class ProductDetails extends StatefulWidget {
  final String productImage;
  final String productName;
  final double productPrice;
  final String productId;
  const ProductDetails({
    Key? key,
    required this.productImage,
    required this.productName,
    required this.productPrice,
    required this.productId,
  }) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isLoading = false;
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Details',style: TextStyle(color: Colors.black),),
        centerTitle: true,
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_ios_new_rounded,color: Colors.black,)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Hero(
                tag: widget.productImage,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(widget.productImage),fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15,),
            Text(widget.productName,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
            Text(
              '\$${widget.productPrice*quantity}',
              style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    onPressed: (){
                      setState(() {
                        quantity > 1 ? quantity-- : null;  
                      });
                    }, 
                    icon: Icon(Icons.remove)
                  )
                ),
                SizedBox(width: 15,),
                Text(
                  '$quantity',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(width: 15,),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    onPressed: (){
                      setState(() {
                        quantity++;
                      });
                    }, 
                    icon: Icon(Icons.add)
                  )
                ),
                Spacer(),
                Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.2,color: Colors.transparent),
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: MaterialButton(
                      color: Colors.black87,
                      disabledColor: Colors.grey.withOpacity(.5),
                      disabledTextColor: Colors.black.withOpacity(.5),
                      onPressed: isLoading ? null : ()async{
                        setState(() {isLoading = true;});
                        FirebaseFirestore.instance
                          .collection('cart')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('userCart')
                          .doc(widget.productId)
                          .set({
                            'productName': widget.productName,
                            'productImage': widget.productImage,
                            'productPrice': widget.productPrice*quantity,
                            'productId': widget.productId,
                            'productQuantity': quantity
                          });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item Added to Cart'),backgroundColor: Colors.green,));
                        setState(() {isLoading = false;});
                      },
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17,color:Colors.white)
                      ),
                    )
                  ),
              ],
            ),
            const SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}
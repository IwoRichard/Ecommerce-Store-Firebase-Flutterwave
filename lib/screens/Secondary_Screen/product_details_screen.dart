// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
class ProductDetails extends StatefulWidget {
  final String productImage;
  final String productName;
  final double productPrice;
  const ProductDetails({
    Key? key,
    required this.productImage,
    required this.productName,
    required this.productPrice,
  }) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
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
            const SizedBox(height: 15,),
            Row(
              children: [
                Text(
                  '\$${widget.productPrice}',
                  style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700),
                ),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  height: 50,
                  width: 150,
                  child: Center(
                    child: Text(
                      'Add to Cart',
                      style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),
                    ),
                  ),
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
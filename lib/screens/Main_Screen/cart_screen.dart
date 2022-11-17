// ignore_for_file: prefer_const_constructors,  prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Row(
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius:  BorderRadius.circular(10),
                            color: Colors.blue
                          ),
                        ),
                        const SizedBox(width: 15,),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 3,left: 3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Nike Everyday Shoe",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 3,),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(child: Text('-'),),
                                    const SizedBox(width: 10,),
                                    Container(child: Text('+'),),
                                    Spacer(),
                                    Text('455')
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                }
              )
            ),
            Row(
              children: [
                Text('Total',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                Spacer(),
                Text('\$500',style: TextStyle(fontSize: 21,fontWeight: FontWeight.w600),)
              ],
            ),
            SizedBox(height: 10,),
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
                  'CheckOut',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17,color:Colors.white)
                ),
              )
            ),
          ],
        )
      )
    );
  }
}
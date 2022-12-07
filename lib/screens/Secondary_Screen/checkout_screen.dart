// ignore_for_file: prefer_const_constructors,  prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import '../../widgets/cart_product_card.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    cartProvider.cartData();
    double subTotal = cartProvider.subTotal();
    double shipping = 10.0;
    double total = subTotal + subTotal;
    //var cs = cartProvider.cartModel!.productQuantity;
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
      body: cartProvider.getCartList.isEmpty ?
      Center(child: Text('Cart is Empty'),) :
      Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: cartProvider.getCartList.length,
                  itemBuilder: (context, index) {
                    var data = cartProvider.cartList[index];
                    return CartCard(
                      productId: data.productId, 
                      productImage: data.productImage, 
                      productName: data.productName, 
                      productQuantity: data.productQuantity, 
                      productPrice: data.productPrice,
                    );
                  }
                )
              ),
              ListTile(
                leading: Text('Sub Total'),
                trailing: Text('\$$subTotal'),
              ),
              ListTile(
                leading: Text('Shipping'),
                trailing: Text('\$$shipping'),
              ),
              Divider(),
              ListTile(
                leading: Text('Total'),
                trailing: Text('\$$total'),
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
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Purchase',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17,color:Colors.white)
                  ),
                )
              ),
            ],
          )
        ),
    );
  }
}
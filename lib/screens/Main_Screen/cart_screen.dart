import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart_provider.dart';
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
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    cartProvider.cartData();
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: .5,
        title: const Text('My Cart',style: TextStyle(fontSize: 34,fontWeight: FontWeight.w600,color: Colors.black),),
      ),
      body: cartProvider.getCartList.isEmpty ?
      const Center(child: Text('Cart is Empty'),) :
      Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Divider();
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
                      MaterialPageRoute(builder: (context)=> const CheckOutScreen())
                    );
                  },
                  child: const Text(
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
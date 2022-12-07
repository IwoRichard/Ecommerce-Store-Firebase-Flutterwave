import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop/models/cart_model.dart';

class CartProvider with ChangeNotifier{
  List<CartModel> cartList = [];
  CartModel? cartModel;

  Future cartData()async{
    List<CartModel> newCartList = [];
    QuerySnapshot querysnapshot = await FirebaseFirestore.instance
      .collection('cart')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('userCart')
      .get();
    
    querysnapshot.docs.forEach((element) { 
      cartModel = CartModel.fromDocument(element);
      notifyListeners();
      newCartList.add(cartModel!);
    });
    cartList = newCartList;
    notifyListeners();
  }

  List<CartModel> get getCartList => cartList;

  double subTotal(){
    double subTotal = 0.0;
    cartList.forEach((element) { 
      subTotal += element.productPrice * element.productQuantity;
    });
    return subTotal;
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  final String productImage;
  final String productName;
  final double productPrice;
  final String productId;
  final int productQuantity;
  CartModel({
    required this.productImage,
    required this.productName,
    required this.productPrice,
    required this.productId,
    required this.productQuantity,
  });
  factory CartModel.fromDocument(QueryDocumentSnapshot doc){
    return CartModel(
      productId: doc['productId'], 
      productImage: doc['productImage'], 
      productName: doc['productName'], 
      productQuantity: doc['productQuantity'], 
      productPrice: doc['productPrice'],
    );
  }
}
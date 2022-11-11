import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop/models/products_model.dart';

class ProductsProvider with ChangeNotifier{
  static List<ProductModel> _productsList = [];

  List<ProductModel> get getProducts{
    return _productsList;}

  Future<void> fetchProducts() async{
    await FirebaseFirestore.instance
      .collection('Products')
      .get()
      .then((snapshot){
        _productsList = [];
        snapshot.docs.forEach((element) { 
          _productsList.insert(
            0, 
            ProductModel(
              id: element.get('id'), 
              title: element.get('title'), 
              imageUrl: element.get('imageUrl'), 
              price: double.parse(element.get('price')),
            )
          );
        });
      });
    notifyListeners();
  }

}
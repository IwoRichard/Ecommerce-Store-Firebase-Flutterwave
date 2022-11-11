import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/products_model.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductModel>(context);
    return Column(
      children: [
        Image.network(productModel.imageUrl),
        Text(productModel.title,style: TextStyle(color: Colors.black,fontSize: 20),),
        Text(productModel.price.toString())
      ],
    );
  }
}
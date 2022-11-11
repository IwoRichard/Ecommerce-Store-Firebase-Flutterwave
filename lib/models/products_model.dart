import 'package:flutter/cupertino.dart';

class ProductModel with ChangeNotifier {
  final String id;
  final String title;
  final String imageUrl;
  final double price;
  ProductModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
  });
}

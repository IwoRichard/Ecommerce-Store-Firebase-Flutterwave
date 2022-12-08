// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shop/screens/Secondary_Screen/product_details_screen.dart';

class CategoryScreen extends StatefulWidget {
  final String id;
  final String collection;
  const CategoryScreen({
    Key? key,
    required this.id,
    required this.collection,
  }) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryState();
}

class _CategoryState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios_new_rounded,color: Colors.black,)),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('categories').doc(widget.id).collection(widget.collection).get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator(),);
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: MasonryGridView.count(
              physics: BouncingScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              itemCount: snapshot.data.docs.length, 
              itemBuilder: (context,index){
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ProductDetails(
                      productId: snapshot.data.docs[index]['productId'],
                      productName: snapshot.data.docs[index]['productName'],
                      productImage: snapshot.data.docs[index]['productImage'],
                      productPrice: snapshot.data.docs[index]['productPrice'], 
                    )));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Hero(
                          tag: snapshot.data.docs[index]['productImage'],
                          child: Image.network(snapshot.data.docs[index]['productImage']))),
                      SizedBox(height: 1,),
                      Text(
                        snapshot.data.docs[index]['productName'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black.withOpacity(.5)),
                      ),
                      SizedBox(height: 3,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '\$${snapshot.data.docs[index]['productPrice'].toString()}',
                            style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }
            ),
          );
        },
      ),
    );
  }
}
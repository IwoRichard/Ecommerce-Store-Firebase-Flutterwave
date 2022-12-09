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
        leading: IconButton(
          onPressed: (){Navigator.pop(context);}, 
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,)),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('categories').doc(widget.id).collection(widget.collection).get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator(),);
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: MasonryGridView.count(
              physics: const BouncingScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              itemCount: snapshot.data.docs.length, 
              itemBuilder: (context,index){
                var data = snapshot.data.docs[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ProductDetails(
                      productId: data['productId'],
                      productName: data['productName'],
                      productImage: data['productImage'],
                      productPrice: data['productPrice'], 
                    )));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Hero(
                          tag: data['productImage'],
                          child: Image.network(data['productImage']))),
                      const SizedBox(height: 1,),
                      Text(
                        data['productName'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black.withOpacity(.5)),
                      ),
                      const SizedBox(height: 3,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '\$${data['productPrice'].toString()}',
                            style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 18),
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
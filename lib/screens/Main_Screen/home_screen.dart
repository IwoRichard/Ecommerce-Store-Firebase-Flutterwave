// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables,use_build_context_synchronously

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<String> items = [
    'home',
    'explore',
    'search',
    'feed',
    'post',
    'activity',
    'settings',
    'profile',
  ];

  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Home',style: TextStyle(fontSize: 34,fontWeight: FontWeight.w600,color: Colors.black),),
        actions: [
          Chip(
            backgroundColor: Color.fromARGB(246, 212, 165, 7),
            label: Text('Get 2\$')
          ),
          SizedBox(width: 15,)
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(55),
          child: Padding(
            padding: EdgeInsets.only(left: 15,right: 15),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.05),
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextFormField(
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  hintText: 'Search, shoes, watch . . .',
                  hintStyle: Theme.of(context).textTheme.headline2?.copyWith(fontSize: 15,color: Colors.grey),
                  prefixIcon: IconButton(
                    onPressed: (){}, 
                    icon: Icon(Icons.search_rounded,color: Colors.grey,)
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.zero,
                  filled: true
                ),
                onFieldSubmitted: (value){},
              ),
            ),
          ) 
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder:(context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Colors.white,
              expandedHeight: 180,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
                  child: Container(color: Colors.grey.withOpacity(.2),),
                ),
              ),
            ),
          ];
        }, 
        body: Container(
          margin: EdgeInsets.only(left: 15),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: 60,
                width: double.infinity,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: items.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                    return GestureDetector(
                      onTap: (){
                        setState(() {
                          current = index;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 5),
                        child: Chip(
                          label: Text(items[index])
                        ),
                      ),
                    );
                  }
                ),
              )
            ],
          ),
        ),
        ),
    );
  }
}
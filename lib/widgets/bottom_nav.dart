// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:shop/screens/Main_Screen/cart_screen.dart';
import 'package:shop/screens/Main_Screen/explore_screen.dart';
import 'package:shop/screens/Main_Screen/home_screen.dart';
import 'package:shop/screens/Main_Screen/user_profile_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});
  

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  List pages = [
    const HomeScreen(),
    const ExploreScreen(),
    const CartScreen(),
    const UserProfileScreen()
  ];
  int currentIndex = 0;
  void onTap(int index){
    setState(() {
      currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: currentIndex,
        children: [
          const HomeScreen(),
          const ExploreScreen(),
          const CartScreen(),
          const UserProfileScreen()
        ]
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        iconSize: 24,
        unselectedFontSize: 13,
        selectedFontSize: 13,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.grey.withOpacity(.5),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 10,
        items: [
          BottomNavigationBarItem(label: 'Home',icon: Icon(Icons.home_rounded)),
          BottomNavigationBarItem(label: 'Explore',icon: Icon(Icons.explore)),
          BottomNavigationBarItem(label: 'Cart',icon: Icon(Icons.shopping_bag_rounded)),
          BottomNavigationBarItem(label: 'Profile',icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
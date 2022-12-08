
// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, must_be_immutable

import 'package:flutter/material.dart';
import '../services/firestore_user_database.dart';

class UserTile extends StatefulWidget {
  String title;
  String? subtitle;
  TextEditingController? nameController;
  TextEditingController? addressController;
  //String? address;
  //String? name;
  String? trailing;
  UserTile({
    Key? key,
    required this.title,
    this.subtitle,
    this.nameController,
    this.addressController,
    //this.address,
    //this.name,
    this.trailing,
  }) : super(key: key);

  @override
  State<UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.grey.withOpacity(.1),
      subtitle: Text(widget.subtitle ?? ''),
      title: Text(widget.title,style: TextStyle(fontWeight: FontWeight.w600),),
      trailing: widget.trailing != null ? GestureDetector(
        onTap: widget.title == 'Display Name' ?
         ()async{
          await showDialog(
            context: context, 
            builder:(context) {
              return AlertDialog(
                title: Text('Edit Name'),
                content: TextField(
                  maxLines: 5,
                  autofocus: true,
                  controller: widget.nameController,
                  decoration: InputDecoration(
                    hintText: 'Edit name'
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: ()async{
                      Navigator.pop(context);
                      await FirestoreService().updateUserName(widget.nameController!.text);
                    }, 
                    child: Text('Save')
                  )
                ],
              );
            },
          );
         } : widget.title == 'Delivery Address' ?
         ()async{
          await showDialog(
            context: context, 
            builder:(context) {
              return AlertDialog(
                title: Text('Edit Address'),
                content: TextField(
                  maxLines: 5,
                  autofocus: true,
                  controller: widget.addressController,
                  decoration: InputDecoration(
                    hintText: 'Edit address'
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: ()async{
                      Navigator.pop(context);
                      await FirestoreService().updateUserAddress(widget.addressController!.text);
                    }, 
                    child: Text('Save')
                  )
                ],
              );
            },
          );
         } : null,
        child: Chip(label: Text(widget.trailing?? '')),
        ) : null,
    );
  }
}
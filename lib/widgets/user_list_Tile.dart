import 'package:flutter/material.dart';
import '../services/firestore_user_database.dart';

class UserTile extends StatefulWidget {
  String title;
  String? subtitle;
  TextEditingController? nameController;
  TextEditingController? addressController;
  String? trailing;
  UserTile({
    Key? key,
    required this.title,
    this.subtitle,
    this.nameController,
    this.addressController,
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
      title: Text(widget.title,style: const TextStyle(fontWeight: FontWeight.w600),),
      trailing: widget.trailing != null ? GestureDetector(
        onTap: widget.title == 'Display Name' ?
         ()async{
          await showDialog(
            context: context, 
            builder:(context) {
              return AlertDialog(
                title: const Text('Edit Name'),
                content: TextField(
                  maxLines: 5,
                  autofocus: true,
                  controller: widget.nameController,
                  decoration: const InputDecoration(
                    hintText: 'Edit name'
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: ()async{
                      Navigator.pop(context);
                      await FirestoreService().updateUserName(widget.nameController!.text);
                    }, 
                    child: const Text('Save')
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
                title: const Text('Edit Address'),
                content: TextField(
                  maxLines: 5,
                  autofocus: true,
                  controller: widget.addressController,
                  decoration: const InputDecoration(
                    hintText: 'Edit address'
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: ()async{
                      Navigator.pop(context);
                      await FirestoreService().updateUserAddress(widget.addressController!.text);
                    }, 
                    child: const Text('Save')
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
import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfo {
  String name;
  String address;
  Timestamp date;
  UserInfo({
    required this.name,
    required this.address,
    required this.date,
  });

  factory UserInfo.fromJson(DocumentSnapshot snapshot){
    return UserInfo(
      name: snapshot['name'], 
      address: snapshot['address'], 
      date: snapshot['date']
    );
  }
}

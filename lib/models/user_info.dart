import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfo {
  String email;
  String name;
  String address;
  Timestamp date;
  UserInfo({
    required this.email,
    required this.name,
    required this.address,
    required this.date,
  });

  factory UserInfo.fromJson(DocumentSnapshot snapshot){
    return UserInfo(
      email: snapshot['email'],
      name: snapshot['name'], 
      address: snapshot['address'], 
      date: snapshot['date']
    );
  }
}

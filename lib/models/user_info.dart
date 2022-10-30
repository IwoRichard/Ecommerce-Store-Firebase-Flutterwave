import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfo {
  String userId;
  String name;
  String address;
  Timestamp date;
  UserInfo({
    required this.userId,
    required this.name,
    required this.address,
    required this.date,
  });

  factory UserInfo.fromJson(DocumentSnapshot snapshot){
    return UserInfo(
      userId: snapshot['userId'], 
      name: snapshot['name'], 
      address: snapshot['address'], 
      date: snapshot['date']
    );
  }
}

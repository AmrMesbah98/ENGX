import 'package:cloud_firestore/cloud_firestore.dart';

class DataHome {
  String? id;
  String? name;
  String? email;


  DataHome(
      {
        required this.id,
        required this.name,
        required this.email,

 });

  DataHome.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    id = json.data()['id'];
    name = json.data()['name'];
    email = json.data()['email'];


  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,

    };
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class DashBoardModel {
  String? id;
  String? code;
  String? name;
  String? email;
  String? identity;
  String? instructor;

  DashBoardModel({
    required this.id,
    required this.code,
    required this.name,
    required this.email,
    required this.identity,
    required this.instructor,
  });

  DashBoardModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    id = json.id;
    code = json.data()['code'];
    name = json.data()['name'];
    email = json.data()['email'];
    identity = json.data()['identity'];
    instructor = json.data()['instructor'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'email': email,
      'identity': identity,
      'instructor': instructor,
    };
  }
}

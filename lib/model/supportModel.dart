import 'package:cloud_firestore/cloud_firestore.dart';

class ModelSupport {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? pic;
  String? reason;
  String? type;

  ModelSupport(
      {
        required this.id,
        required this.name,
      required this.email,
      required this.phone,
      required this.pic,
      required this.reason,
      required this.type});

  ModelSupport.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    id = json.data()['id'];
    name = json.data()['name'];
    email = json.data()['email'];
    phone = json.data()['phone'];
    pic = json.data()['pic'];
    reason = json.data()['reason'];
    type = json.data()['type'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'pic': pic,
      'reason': reason,
      'type': type,
    };
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel
{
  String? id;
  String? name;
  String? email;
  String? address;
  String? order;
  String? phone;
  String? type;

  OrderModel({required this.name, required this.email,required this.address,required this.order, required this.phone, required this.type});

  OrderModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    id = json.data()['id'];
    name = json.data()['name'];
    email = json.data()['email'];
    address = json.data()['Address'];
    order = json.data()['order'];
    phone = json.data()['phone'];
    type = json.data()['type'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'Address': address,
      'order': order,
      'phone': phone,
      'type': type,
    };
  }
}
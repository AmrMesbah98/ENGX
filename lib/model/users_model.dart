import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? address;
  String? phone;
  String? type;
  String? position;
  String? code;
  String? specialization;
  String? bio;
  int? updateCode;
  List<dynamic>? arrayMsg;


  UserModel(
      {required this.id,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.address,
        required this.phone,
        required this.type,
        required this.position,
        required this.code,
        required this.specialization,
        required this.bio,
        this.updateCode = 1,
        required this.arrayMsg,


      });

  UserModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    id = json.id;
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    address = json['address'];
    phone = json['phone'];
    type = json['type'];
    position = json['position'];
    code = json['code'];
    specialization = json['specialization'];
    bio = json['bio'];
    updateCode = json['updateCode'];
    arrayMsg = json['arrayMsg'];


  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'address': address,
      'phone': phone,
      'type': type,
      'position': position,
      'code': code,
      'specialization': specialization,
      'bio':bio,
      'updateCode':updateCode,
      'arrayMsg': arrayMsg,


    };
  }
}

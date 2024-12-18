import 'package:cloud_firestore/cloud_firestore.dart';

class InstructorModel {
  String? id;
  String? image;
  String? name;
  String? email;
  String? university;
  String? jop;
  String? specialization;
  String? experience;
  String? phone;
  String? rate;
  List<dynamic>? comment;
  List<dynamic>? nameUser;
  List<dynamic>? rateUser;
  dynamic numberUserRate;





  InstructorModel({
    this.id,
    this.image,
    this.name,
    this.email,
    this.university,
    this.jop,
    this.specialization,
    this.experience,
    this.phone,
    this.rate,
    this.comment,
    this.nameUser,
    this.rateUser,
    this.numberUserRate,

  });



  InstructorModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    id = json.id;
    image = json.data()['image'];
    name = json.data()['name'];
    email = json.data()['email'];
    phone = json.data()['phone'];
    university = json.data()['university'];
    jop = json.data()['jop'];
    specialization = json.data()['specialization'];
    experience = json.data()['experience'];
    rate = json.data()['rate'];
    comment = json.data()['comment'];
    nameUser = json.data()['nameUser'];
    rateUser = json.data()['rateUser'];
    numberUserRate = json.data()['numberUserRate'];


  }



  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'phone': phone,
      'name': name,
      'email': email,
      'university': university,
      'jop': jop,
      'specialization': specialization,
      'experience': experience,
      'rate': rate,
      'comment': comment,
      'nameUser' :nameUser,
      'rateUser' :rateUser,
      'numberUserRate' :numberUserRate,
    };
  }
}
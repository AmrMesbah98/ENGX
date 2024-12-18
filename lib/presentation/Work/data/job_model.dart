import 'package:cloud_firestore/cloud_firestore.dart';

class JobModel {
  String? id;
  String? name;
  String? phone;
  String? location;
  String? company;
  // String? time;
  // String? price;
  String? possition;
  String? specialization;
  String? nameJob;
  String? image;
  String? date;
  String? email;
  String? code;



  JobModel({
    this.id,
    this.name,
    this.phone,
    this.location,
    this.company,
    // this.time,
    // this.price,
    this.possition,
    this.specialization,
    this.nameJob,
    this.image,
    this.date,
    this.email,
    this.code,



  });

  JobModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    id = json.id;
    name = json.data()['name'];
    phone = json.data()['phone'];
    location = json.data()['location'];
    company = json.data()['company'];
    // time = json.data()['time'];
    // price = json.data()['price'];
    possition = json.data()['possition'];
    specialization = json.data()['specialization'];
    nameJob = json.data()['nameJob'];
    image = json.data()['image'];
    date = json.data()['date'];
    email = json.data()['email'];
    code = json.data()['code'];

  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'location': location,
      'company': company,
      // 'time': time,
      // 'price': price,
      'possition': possition,
      'specialization': specialization,
      'nameJob': nameJob,
      'image': image,
      'date': date,
      'email': email,
      'code': code,

    };
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class InnerRequestModel {
  String? id;
  String? time;
  String? jopType;
  String? desc;
  String? skills;
  String? gradYear;
  String? active;

  String? phone;
  String? location;
  String? company;
  String? salary;
  String? possition;
  String? specialization;
  String? nameJob;
  String? image;
  //String? date;
  String? email;
  String? experience;



  InnerRequestModel({
    this.id,
    this.time,
    this.jopType,
    this.desc,
    this.skills,
    this.gradYear,
    this.active,

    this.phone,
    this.location,
    this.company,
    this.salary,
    this.possition,
    this.specialization,
    this.nameJob,
    this.image,
    //this.date,
    this.email,
    this.experience,



  });

  InnerRequestModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    id = json.id;
    time = json.data()['time'];
    jopType = json.data()['jopType'];
    desc = json.data()['desc'];
    skills = json.data()['skills'];
    gradYear = json.data()['gradYear'];
    active = json.data()['active'];

    phone = json.data()['phone'];
    location = json.data()['location'];
    company = json.data()['company'];
    salary = json.data()['salary'];
    possition = json.data()['possition'];
    specialization = json.data()['specialization'];
    nameJob = json.data()['nameJob'];
    image = json.data()['image'];
    //date = json.data()['date'];
    email = json.data()['email'];
    experience = json.data()['experience'];


  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'time': time,
      'jopType': jopType,
      'desc': desc,
      'skills': skills,
      'gradYear': gradYear,
      'active': active,

      'phone': phone,
      'location': location,
      'company': company,
      'salary': salary,
      'possition': possition,
      'specialization': specialization,
      'nameJob': nameJob,
      'image': image,
      //'date': date,
      'email': email,
      'experience': experience,

    };
  }
}

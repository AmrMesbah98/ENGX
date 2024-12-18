import 'package:cloud_firestore/cloud_firestore.dart';

class CvModelCV {
  String? firstname;
  String? lastname;
  String? email;
  String? phone;
  String? address;
  String? linkedin;
  String? faculty;
  String? facebook;
  String? like;

  String? experienceYear;
  String? graduationYear;
  String? companyName;
  String? startDate;
  String? endDate;
  String? shareProject;
  String? positionCv;
  String? specialization;
  List? pro ;




  CvModelCV({
    this.firstname,
    this.lastname,
    this.email,
    this.phone,
    this.address,
    this.faculty,
    this.facebook,
    this.like,

    this.linkedin,
    this.companyName,
    this.startDate,
    this.endDate,
    this.shareProject,
    this.positionCv,
    this.experienceYear,
    this.graduationYear,
    this.specialization,
    this.pro,
  });

  CvModelCV.fromJson(Map<String, dynamic> json) {

    firstname = json['firstname'] as String;
    lastname = json['lastname'] as String;
    email = json['email'] as String;
    phone = json['phone'] as String;
    address = json['address'] as String;
    like = json['like'] as String;
    facebook = json['facebook'] as String;

    faculty = json['faculty'] as String;
    companyName = json['companyName'] as String;
    startDate = json['startDate'] as String;
    endDate = json['endDate'] as String;
    shareProject = json['shareProject'] as String;
    positionCv = json['positionCv'] as String;
    linkedin = json['linkedin'] as String;
    experienceYear = json['experienceYear'] as String;
    specialization = json['specialization'] as String;
    graduationYear = json['graduationYear'] as String;
    pro = json['pro'] as List;
  }

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'phone': phone,
      'address': address,
      'like': like,
      'facebook': facebook,

      'faculty': faculty,
      'companyName': companyName,
      'startDate': startDate,
      'endDate': endDate,
      'shareProject': shareProject,
      'positionCv': positionCv,
      'linkedin': linkedin,
      'experienceYear': experienceYear,
      'specialization': specialization,
      'graduationYear': graduationYear,
      'pro': pro,
    };
  }
}
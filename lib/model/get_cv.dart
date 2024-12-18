import 'package:cloud_firestore/cloud_firestore.dart';

class GetCvModel {
  String? firstname;
  String? lastname;
  String? email;
  String? phone;
  String? address;
  String? linkedin;
  String? gpa;

  String? faculty;
  String? facebook;
  String? like;

  String? state;
  String? military;


  String? graduationYear;
  String? companyName;
  String? startDate;

  String? shareProject;
  String? positionCv;
  String? specialization;
  List? pro ;




  GetCvModel({
    this.firstname,
    this.lastname,
    this.email,
    this.phone,
    this.address,
    this.faculty,
    this.facebook,
    this.like,
    this.linkedin,
    this.gpa,
    this.companyName,
    this.startDate,

    this.shareProject,
    this.positionCv,

    this.state,
    this.military,


    this.graduationYear,
    this.specialization,
    this.pro,
  });

  GetCvModel.fromJson(Map<String, dynamic> json) {

    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    like = json['like'];
    facebook = json['facebook'];

    faculty = json['faculty'];
    companyName = json['companyName'];
    startDate = json['startDate'];

    shareProject = json['shareProject'];
    positionCv = json['positionCv'];

    state = json['state'];
    military = json['military'];



    linkedin = json['linkedin'];
    gpa = json['gpa'];



    specialization = json['specialization'];
    graduationYear = json['graduationYear'];
    pro = json['pro'];
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

      'shareProject': shareProject,
      'positionCv': positionCv,
      'linkedin': linkedin,
      'gpa': gpa,

      'state': state,
      'military': military,


      'specialization': specialization,
      'graduationYear': graduationYear,
      'pro': pro,
    };
  }
}
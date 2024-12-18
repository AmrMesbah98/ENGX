import 'package:cloud_firestore/cloud_firestore.dart';

class InnerResponseModel {
  String? id;
  String? firstname;
  String? lastname;
  String? email;
  String? phone;
  String? addressStNum;
  String? addressStName;
  String? address;
  String? linkedin;
  String? gpa;
  String? faculty;
  String? facebook;
  String? like;
  String? graduationYear;
  String? companyName;
  String? startDate;

  String? shareProject;
  String? positionCv;
  String? specialization;
  String? state;
  String? military;

  List? pro ;
  bool? work;
  bool? isTrain;
  List? listHobbies;




  InnerResponseModel({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.phone,
    this.addressStNum,
    this.addressStName,
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


    this.graduationYear,
    this.specialization,
    this.state,
    this.military,

    this.pro,
    this.work,
    this.isTrain,
    this.listHobbies,
  });

  InnerResponseModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    id = json.id;
    firstname = json.data()['firstname'];
    lastname = json.data()['lastname'];
    email = json.data()['email'];
    addressStNum = json.data()['StNum'];
    addressStName = json.data()['StName'];
    phone = json.data()['phone'];
    address = json.data()['address'];
    like = json.data()['like'];
    facebook = json.data()['facebook'];

    faculty = json.data()['faculty'];
    companyName = json.data()['companyName'];
    startDate = json.data()['startDate'];

    shareProject = json.data()['shareProject'];
    positionCv = json.data()['positionCv'];
    linkedin = json.data()['linkedin'];
    state = json.data()['state'];
    military = json.data()['military'];

    gpa = json.data()['gpa'];



    specialization = json.data()['specialization'];
    graduationYear = json.data()['graduationYear'];
    pro = json.data()['pro'];
    work = json.data()['work'];
    isTrain = json.data()['isTrain'];
    listHobbies = json.data()['listHobbies'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'phone': phone,
      'StNum': addressStNum,
      'StName': addressStName,
      'address': address,
      'like': like,
      'facebook': facebook,

      'faculty': faculty,
      'companyName': companyName,
      'startDate': startDate,

      'shareProject': shareProject,
      'positionCv': positionCv,
      'linkedin': linkedin,
      'state': state,
      'military': military,
      'gpa': gpa,



      'specialization': specialization,
      'graduationYear': graduationYear,
      'pro': pro,
      'work': work,
      'isTrain': isTrain,
      'listHobbies': listHobbies,
    };
  }
}
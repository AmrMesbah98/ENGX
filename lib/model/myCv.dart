import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:json_annotation/json_annotation.dart';

part 'myCv.g.dart';

@JsonSerializable()

class MyCvModel {
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




  MyCvModel({
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


  factory MyCvModel.fromJson(Map<String, dynamic> json) =>
      _$MyCvModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyCvModelToJson(this);

}
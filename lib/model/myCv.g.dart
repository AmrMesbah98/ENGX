// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'myCv.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyCvModel _$MyCvModelFromJson(Map<String, dynamic> json) => MyCvModel(
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      addressStNum: json['addressStNum'] as String?,
      addressStName: json['addressStName'] as String?,
      address: json['address'] as String?,
      faculty: json['faculty'] as String?,
      facebook: json['facebook'] as String?,
      like: json['like'] as String?,
      linkedin: json['linkedin'] as String?,
      gpa: json['gpa'] as String?,
      companyName: json['companyName'] as String?,
      startDate: json['startDate'] as String?,
      shareProject: json['shareProject'] as String?,
      positionCv: json['positionCv'] as String?,
      graduationYear: json['graduationYear'] as String?,
      specialization: json['specialization'] as String?,
      state: json['state'] as String?,
      military: json['military'] as String?,
      pro: json['pro'] as List<dynamic>?,
      work: json['work'] as bool?,
      isTrain: json['isTrain'] as bool?,
      listHobbies: json['listHobbies'] as List<dynamic>?,
    );

Map<String, dynamic> _$MyCvModelToJson(MyCvModel instance) => <String, dynamic>{
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'email': instance.email,
      'phone': instance.phone,
      'addressStNum': instance.addressStNum,
      'addressStName': instance.addressStName,
      'address': instance.address,
      'linkedin': instance.linkedin,
      'gpa': instance.gpa,
      'faculty': instance.faculty,
      'facebook': instance.facebook,
      'like': instance.like,
      'graduationYear': instance.graduationYear,
      'companyName': instance.companyName,
      'startDate': instance.startDate,
      'shareProject': instance.shareProject,
      'positionCv': instance.positionCv,
      'specialization': instance.specialization,
      'state': instance.state,
      'military': instance.military,
      'pro': instance.pro,
      'work': instance.work,
      'isTrain': instance.isTrain,
      'listHobbies': instance.listHobbies,
    };

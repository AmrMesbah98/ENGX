// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplicationUser _$ApplicationUserFromJson(Map<String, dynamic> json) =>
    ApplicationUser(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      address: json['address'] as String,
      phone: json['phone'] as String,
      type: json['type'] as String,
      position: json['position'] as String,
      code: json['code'] as String,
      specialization: json['specialization'] as String,
      bio: json['bio'] as String,
      updateCode: (json['updateCode'] as num?)?.toInt() ?? 1,
      arrayMsg: json['arrayMsg'] as List<dynamic>?,
      chat: json['chat'] as String?,
    );

Map<String, dynamic> _$ApplicationUserToJson(ApplicationUser instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'address': instance.address,
      'phone': instance.phone,
      'type': instance.type,
      'position': instance.position,
      'code': instance.code,
      'specialization': instance.specialization,
      'bio': instance.bio,
      'updateCode': instance.updateCode,
      'arrayMsg': instance.arrayMsg,
      'chat': instance.chat,
    };

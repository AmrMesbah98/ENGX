// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_Model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportMethod _$SupportMethodFromJson(Map<String, dynamic> json) =>
    SupportMethod(
      json['id'] as String,
      json['name'] as String,
      json['email'] as String,
      json['phone'] as String,
      json['reason'] as String,
      json['type'] as String,
      json['pic'] as String,
    );

Map<String, dynamic> _$SupportMethodToJson(SupportMethod instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'reason': instance.reason,
      'type': instance.type,
      'pic': instance.pic,
    };

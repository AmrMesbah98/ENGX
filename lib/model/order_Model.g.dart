// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_Model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MakeOrder _$MakeOrderFromJson(Map<String, dynamic> json) => MakeOrder(
      json['id'] as String,
      json['order'] as String,
      json['name'] as String,
      json['email'] as String,
      json['Address'] as String,
      json['phone'] as String,
      json['type'] as String,
    );

Map<String, dynamic> _$MakeOrderToJson(MakeOrder instance) => <String, dynamic>{
      'id': instance.id,
      'order': instance.order,
      'name': instance.name,
      'email': instance.email,
      'Address': instance.Address,
      'phone': instance.phone,
      'type': instance.type,
    };

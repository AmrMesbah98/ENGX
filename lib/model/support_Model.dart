import 'package:json_annotation/json_annotation.dart';

part 'support_Model.g.dart';

@JsonSerializable()
class SupportMethod {
  String id;
  String name;
  String email;
  String phone;
  String reason;
  String type;
  String pic;


  SupportMethod(
      this.id,
      this.name,
      this.email,
      this.phone,
      this.reason,
      this.type,
      this.pic
      );

  factory SupportMethod.fromJson(Map<String, dynamic> json)=>
      _$SupportMethodFromJson(json);

  Map<String, dynamic> toJson() => _$SupportMethodToJson(this);
}
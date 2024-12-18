import 'package:json_annotation/json_annotation.dart';

part 'app_user.g.dart';

@JsonSerializable()
class ApplicationUser {
  String firstName;
  String lastName;
  String email;
  String address;
  String phone;
  String type;
  String position;
  String code;
  String specialization;
  String bio;
  int updateCode;
  List<dynamic>? arrayMsg;
  String? chat;



  ApplicationUser({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.address,
    required this.phone,
    required this.type,
    required this.position,
    required this.code,
    required this.specialization,
    required this.bio,
    this.updateCode = 1,
    this.arrayMsg,
    this.chat,

  });

  factory ApplicationUser.fromJson(Map<String, dynamic> json) =>
      _$ApplicationUserFromJson(json);

  Map<String, dynamic> toJson() => _$ApplicationUserToJson(this);
}

import 'package:cloud_firestore/cloud_firestore.dart';

class CertificationModel
{
  String? id;
  String? name;
  String? grade;
  String? nameCourses;
  String? stateCourses;
  int? degree;
  String? serialNumber;

  CertificationModel({required this.id,required this.name, required this.grade, required this.nameCourses, required this.stateCourses, required this.degree,required this.serialNumber});

  CertificationModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    id = json.id;
    name = json.data()['name'];
    grade = json.data()['grade'];
    nameCourses = json.data()['nameCourses'];
    stateCourses = json.data()['stateCourses'];
    degree = json.data()['degree'];
    serialNumber = json.data()['serialNumber'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'grade': grade,
      'nameCourses': nameCourses,
      'stateCourses': stateCourses,
      'degree': degree,
      'serialNumber': serialNumber,
    };
  }
}
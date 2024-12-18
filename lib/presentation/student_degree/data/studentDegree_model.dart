import 'package:cloud_firestore/cloud_firestore.dart';

class StudentDegreeModel {
  String? id;
  String? name;
  String? idUser;
  String? track;
  String? instructor;
  String? degree;
  bool? showData;

  StudentDegreeModel({
    this.id,
    this.name,
    this.idUser,
    this.track,
    this.instructor,
    this.degree,
    this.showData,
  });

  StudentDegreeModel.fromJson(
      QueryDocumentSnapshot<Map<String, dynamic>> json) {
    id = json.id;
    name = json.data()['name'];
    idUser = json.data()['idUser'];
    track = json.data()['track'];
    instructor = json.data()['instructor'];
    degree = json.data()['degree'];
    showData = json.data()['showData'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'idUser': idUser,
      'track': track,
      'instructor': instructor,
      'degree': degree,
      'showData': showData,
    };
  }
}

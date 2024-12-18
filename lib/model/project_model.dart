import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectModel {
  String? id;
  String? category;
  String? date;
  String? clientName;
  String? details;
  String? iamge;
  String? location;
  String? area;
  List? photo ;
  List? workScope ;
  List? designBy;




  ProjectModel({
   required this.id,
    required  this.category,
    required  this.date,
    required  this.details,
    required this.iamge,
    required this.location,
     this.photo,
    this.clientName,
    this.workScope,
    this.designBy,
    this.area

  });

  ProjectModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    id = json.id;
    category = json.data()['category'];
    date = json.data()['date'];
    clientName = json.data()['clientName'];
    details = json.data()['details'];
    area = json.data()['area'];
    iamge = json.data()['iamge'];
    location = json.data()['location'];
    photo = json.data()['photo'];
    workScope = json.data()['workScope'];
    designBy = json.data()['designBy'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'date': date,
      'clientName': clientName,
      'details': details,
      'area': area,
      'iamge': iamge,
      'location': location,
      'photo': photo,
      'workScope': workScope,
      'designBy': designBy,
    };
  }
}
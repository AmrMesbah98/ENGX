import 'package:cloud_firestore/cloud_firestore.dart';

class FreeCoursesModel {
  String? id;
  String? title;
  String? image;
  String? rate;
  List<dynamic>? comment;
  List<dynamic>? nameUser;
  List<dynamic>? rateUser;
  dynamic numberUserRate;



  FreeCoursesModel({
    this.id,
    this.title,
    this.image,
    this.rate,
    this.comment,
    this.nameUser,
    this.rateUser,
    this.numberUserRate,


  });

  FreeCoursesModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    id = json.id;
    title = json.data()['title'];
    image = json.data()['image'];
    rate = json.data()['rate'];
    comment = json.data()['comment'];
    nameUser = json.data()['nameUser'];
    rateUser = json.data()['rateUser'];
    numberUserRate = json.data()['numberUserRate'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'rate': rate,
      'comment': comment,
      'nameUser' :nameUser,
      'rateUser' :rateUser,
      'numberUserRate' :numberUserRate,

    };
  }
}

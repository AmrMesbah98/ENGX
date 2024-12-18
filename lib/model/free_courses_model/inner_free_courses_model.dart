import 'package:cloud_firestore/cloud_firestore.dart';

class InnerFreeCoursesModel {
  String? id;
  String? title;
  String? link;
  String? image;



  InnerFreeCoursesModel({
    this.id,
    this.title,
    this.link,
    this.image,


  });

  InnerFreeCoursesModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    id = json.id;
    title = json.data()['title'];
    link = json.data()['link'];
    image = json.data()['image'];

  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'link': link,
      'image': image,

    };
  }
}

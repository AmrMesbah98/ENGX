import 'package:cloud_firestore/cloud_firestore.dart';

class ZoomMeetingModel {
  String? id;
  String? title;
  String? image;
  String? name;



  ZoomMeetingModel({
    this.id,
    this.title,
    this.image,
    this.name,


  });

  ZoomMeetingModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    id = json.id;
    title = json.data()['title'];
    image = json.data()['image'];
    name = json.data()['name'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'name': name,

    };
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class PodCastModel {
  String? title;
  String? link;
  String? image;
  String? des;

  PodCastModel({
    this.title,
    this.link,
    this.image,
    this.des,
  });

  PodCastModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    title = json.data()['title'];
    link = json.data()['link'];
    image = json.data()['image'];
    des = json.data()['des'];
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'link': link,
      'image': image,
      'des': des,
    };
  }
}

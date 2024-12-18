import 'package:cloud_firestore/cloud_firestore.dart';

class ShortsModel {
  String? id;
  String? small_image;
  String? image;
  String? link;


  ShortsModel({
    this.id,
    this.small_image,
    this.image,
    this.link,

  });

  ShortsModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    id = json.id;
    small_image = json.data()['small_image'];
    image = json.data()['image'];
    link = json.data()['link'];

  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'small_image': small_image,
      'image': image,
      'link': link,

    };
  }
}
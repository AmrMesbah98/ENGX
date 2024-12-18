import 'package:cloud_firestore/cloud_firestore.dart';

class VideoCoursesModel {
  String? id;
  String? title;
  String? image;
  String? link;
  String? price;
  List<dynamic>? promoCode;


  VideoCoursesModel({
    this.id,
    this.title,
    this.image,
    this.price,
    this.link,
    required this.promoCode,


  });

  VideoCoursesModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    id = json.id;
    title = json.data()['title'];
    image = json.data()['image'];
    price = json.data()['price'];
    link = json.data()['link'];
    promoCode = json.data()['promoCode'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'price': price,
      'link': link,
      'promoCode': promoCode,
    };
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';

class InnerCategoryModel {
  String? id;
  String? image;
  String? link;
  String? title;
  String? des;  //for name instructor
  List<dynamic>? promoCode;


  InnerCategoryModel({
    required this.id,
    required this.image,
    required this.link,
    required this.title,
    required this.des,
    required this.promoCode,

  });

  InnerCategoryModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    id = json.id;
    image = json.data()['image'];
    link = json.data()['link'];
    title = json.data()['title'];
    des = json.data()['des'];
    promoCode = json.data()['promoCode'];

  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'link': link,
      'title': title,
      'des': des,
      'promoCode': promoCode,



    };
  }
}

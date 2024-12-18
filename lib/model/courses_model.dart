import 'package:cloud_firestore/cloud_firestore.dart';

class CoursesModel {
  String? id;
  String? nameCourse;
  String? nameInstructor;
  String? images;
  String? description;
  String? moreDetails;
  String? price;
  String? priceHalf;
  String? link;
  String? rate;
  List? learn;
  List<dynamic>? comment;
  List<dynamic>? nameUser;
  List<dynamic>? rateUser;
  dynamic numberUserRate;


  CoursesModel({
    this.id,
    this.nameCourse,
    this.nameInstructor,
    this.images,
    this.description,
    this.moreDetails,
    this.price,
    this.priceHalf,
    this.link,
    this.rate,
    this.learn,
    this.comment,
    this.nameUser,
    this.rateUser,
    this.numberUserRate,

  });

  CoursesModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    id = json.id;
    nameCourse = json.data()['nameCourse'];
    nameInstructor = json.data()['nameInstructor'];
    images = json.data()['images'];
    description = json.data()['description'];
    moreDetails = json.data()['moreDetails'];
    price = json.data()['price'];
    priceHalf = json.data()['priceHalf'];
    link = json.data()['link'];
    learn = json.data()['learn'];
    rate = json.data()['rate'];
    comment = json.data()['comment'];
    nameUser = json.data()['nameUser'];
    rateUser = json.data()['rateUser'];
    numberUserRate = json.data()['numberUserRate'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameCourse': nameCourse,
      'nameInstructor': nameInstructor,
      'images': images,
      'description': description,
      'moreDetails': moreDetails,
      'price': price,
      'priceHalf': priceHalf,
      'link': link,
      'learn': learn,
      'rate': rate,
      'comment': comment,
      'nameUser' :nameUser,
      'rateUser' :rateUser,
      'numberUserRate' :numberUserRate,
    };
  }
}
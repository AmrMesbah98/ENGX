import 'package:cloud_firestore/cloud_firestore.dart';

class PackageCourses {
  String? description;
  String? id;
  String? images;
  List? learn;
  String? link;
  String? moreDetails;
  String? nameCourse;
  String? nameInstructor;
  String? price;
  String? halfPrice;
  String? rate;
  List<dynamic>? comment;
  List<dynamic>? nameUser;
  List<dynamic>? rateUser;
  dynamic numberUserRate;

  PackageCourses(
      {this.id,
      this.nameCourse,
      this.nameInstructor,
      this.images,
      this.description,
      this.moreDetails,
      this.price,
      this.halfPrice,
      this.link,
      this.rate,
      this.learn,
        this.comment,
        this.nameUser,
        this.rateUser,
        this.numberUserRate,
      });

  PackageCourses.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    id = json.id;
    nameCourse = json.data()['nameCourse'];
    nameInstructor = json.data()['nameInstructor'];
    images = json.data()['images'];
    description = json.data()['description'];
    moreDetails = json.data()['moreDetails'];
    price = json.data()['price'];
    halfPrice = json.data()['halfPrice'];
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
      'halfPrice': halfPrice,
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

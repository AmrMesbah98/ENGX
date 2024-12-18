import 'package:cloud_firestore/cloud_firestore.dart';

class Partners
{
  String? id;
   String? images;

  Partners({required this.images, required this.id});

  Partners.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    images = json.data()['images'];
    id = json.data()['id'];
  }

   Map<String, dynamic> toJson() {
     return {
       'images': images,
       'id': id,
     };
   }
}
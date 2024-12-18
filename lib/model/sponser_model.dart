import 'package:cloud_firestore/cloud_firestore.dart';

class Sponser
{
  String? id;
  String? images;

  Sponser({required this.images, required this.id});

  Sponser.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
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
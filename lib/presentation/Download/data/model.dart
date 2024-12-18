import 'package:cloud_firestore/cloud_firestore.dart';

class DownloadModel {
  String? id;
  String? name;
  String? category;
  String? url;

  DownloadModel({
    required this.id,
    required this.name,
    required this.category,
    required this.url,
  });

  DownloadModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    id = json.id;
    name = json.data()['name'];
    category = json.data()['category'];
    url = json.data()['url'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'url': url,
    };
  }
}

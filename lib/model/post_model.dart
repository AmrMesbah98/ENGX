import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel
{
  String? id;
  String? name;
  String? postTitle;
  String? postDescription;
  String? comment;
  bool? isShow;

  PostModel({required this.postTitle, required this.postDescription,required this.comment,required this.isShow, required this.name});

  PostModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    id = json.id;
    postTitle = json.data()['postTitle'];
    name = json.data()['name'];
    postDescription = json.data()['postDescription'];
    comment = json.data()['comment'];
    isShow = json.data()['isShow'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'postTitle': postTitle,
      'name': name,
      'postDescription': postDescription,
      'comment': comment,
      'isShow': isShow,
    };
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';

class NewsModel
{
  String? title;
  String? id;
  String? description;
  String? date;


  NewsModel({ required this.title, required this.description, required this.date});

  NewsModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    title = json.data()['title'];
    id = json.id;
    description = json.data()['description'];
    date = json.data()['date'];

  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,

    };
  }
}
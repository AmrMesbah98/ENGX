import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationShowModel
{
  String? text;
  String? date;


  NotificationShowModel({required this.text,required this.date});

  NotificationShowModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    text = json.data()['text'];
    date = json.data()['date'];

  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'date': date,
    };
  }
}
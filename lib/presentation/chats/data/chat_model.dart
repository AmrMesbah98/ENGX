import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String? id;
  Map<String,dynamic>? msg;




  ChatModel({
    this.id,
    this.msg,

  });

  ChatModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    id = json.id;
    msg = json.data()['msg'];

  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'msg': msg,

    };
  }
}
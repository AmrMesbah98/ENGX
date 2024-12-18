// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class CreatePost {
//   String? id;
//   String? name;
//   String? dateTime;
//   String? text;
//   String? postImage;
//
//   CreatePost({this.name, this.dateTime, this.text, this.postImage, this.id});
//
//   CreatePost.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
//
//     id = json.data()['id'];
//     name = json.data()['name'];
//     dateTime = json.data()['email'];
//     text = json.data()['text'];
//     postImage = json.data()['postImage'];
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'email': dateTime,
//       'text': text,
//       'postImage': postImage,
//     };
//   }
// }

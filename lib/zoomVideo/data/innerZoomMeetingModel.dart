import 'package:cloud_firestore/cloud_firestore.dart';

class InnerZoomMeetingModel {
  String? id;
  String? title;
  String? link;
  String? image;
  String? dsc1;
  String? dsc2;
  String? dsc3;
  String? dsc4;
  //String? desc;
  String? quiz;


  InnerZoomMeetingModel({
    this.id,
    this.title,
    this.link,
    this.image,
    this.dsc1,
    this.dsc2,
    this.dsc3,
    this.dsc4,
    this.quiz,

  });

  InnerZoomMeetingModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    id = json.id;
    title = json.data()['title'];
    link = json.data()['link'];
    image = json.data()['image'];
    dsc1 = json.data()['desc1'];
    dsc2 = json.data()['desc2'];
    dsc3 = json.data()['desc3'];
    dsc4 = json.data()['desc4'];

    quiz = json.data()['quiz'];

  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'link': link,
      'image': image,
      'desc1': dsc1,
      'desc2': dsc2,
      'desc3': dsc3,
      'desc4': dsc4,
      'quiz':quiz,

    };
  }
}

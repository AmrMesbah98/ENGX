import 'package:cloud_firestore/cloud_firestore.dart';

class InnerQuizModel {
  String? id;
  String? question;
  List<dynamic>? answers;
  List<dynamic>? degree;

  InnerQuizModel({
    this.id,
    this.question,
    this.answers,
    this.degree,
  });

  InnerQuizModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    id = json.id;
    question = json.data()['question'];
    answers = json.data()['answers'];
    degree = json.data()['degree'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'answers': answers,
      'degree': degree,

    };
  }
}

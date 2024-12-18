import 'package:cloud_firestore/cloud_firestore.dart';

class QuizModel
{
  String? id;
  String? question;
  List? answers;
  List? degree;




  QuizModel({required this.question, required this.degree,required this.answers,});

  QuizModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
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
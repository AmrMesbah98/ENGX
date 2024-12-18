import 'package:cloud_firestore/cloud_firestore.dart';

class QuizDegreeModel
{
  String? id;
  String? name;
  String? degree;
  String? quiz;




  QuizDegreeModel({required this.name, required this.degree,required this.quiz,});

  QuizDegreeModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    id = json.id;
    name = json.data()['name'];
    degree = json.data()['degree'];
    quiz = json.data()['quiz'];


  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'degree': degree,
      'quiz': quiz,
    };
  }
}
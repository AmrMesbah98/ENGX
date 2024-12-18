import 'package:cloud_firestore/cloud_firestore.dart';

class WeekTesterModel {
  String? id;
  String? degree;
  String? degreeOfInstructor;
  String? instructor;
  String? questionThree;
  String? questionOne;
  String? questionTwo;
  String? subject;
  String? submit;
  String? open;
  int? order;

  WeekTesterModel({
    required this.id,
    required this.degree,
    required this.degreeOfInstructor,
    required this.instructor,
    required this.questionThree,
    required this.questionOne,
    required this.questionTwo,
    required this.subject,
    required this.submit,
    required this.open,
    required this.order,
  });

  WeekTesterModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    id = json.id;
    degree = json.data()['degree'];
    degreeOfInstructor = json.data()['degreeOfInstructor'];
    instructor = json.data()['instructor'];
    questionOne = json.data()['question one'];
    questionTwo = json.data()['questionTwo'];
    questionThree = json.data()['question Three'];
    subject = json.data()['subject'];
    submit = json.data()['submit'];
    open = json.data()['open'];
    order = json.data()['order'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'degree': degree,
      'degreeOfInstructor': degreeOfInstructor,
      'instructor': instructor,
      'question one': questionOne,
      'questionTwo': questionTwo,
      'question Three': questionThree,
      'subject': subject,
      'submit': submit,
      'open': open,
      'order': order,
    };
  }
}

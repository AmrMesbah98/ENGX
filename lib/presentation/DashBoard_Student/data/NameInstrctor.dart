import 'package:cloud_firestore/cloud_firestore.dart';

class NameInstructor {
  String? id;
  List? nameInstructor;

  NameInstructor({
    required this.id,
    required this.nameInstructor,
  });

  NameInstructor.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    id = json.id;
    nameInstructor = json.data()['nameInstrctor'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameInstrctor': nameInstructor,
    };
  }
}

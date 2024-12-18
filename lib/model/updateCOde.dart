import 'package:cloud_firestore/cloud_firestore.dart';

class CodeUpdateModel {

  int? codeUpdate;

  CodeUpdateModel({

    this.codeUpdate,
  });


  CodeUpdateModel.fromJson(Map<String, dynamic> json) {
    codeUpdate = json['code'];
  }

  Map<String, dynamic> toJson() {
    return {
      'code': codeUpdate,

    };
  }
}


import 'package:cloud_firestore/cloud_firestore.dart';

class IdListModel {

  List<dynamic>? idList;




  IdListModel({

    this.idList,

  });

  IdListModel.fromJson(Map<String, dynamic> json) {
    idList = json['idList'];

  }

  Map<String, dynamic> toJson() {
    return {

      'idList': idList,

    };
  }
}


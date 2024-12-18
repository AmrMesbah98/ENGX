import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'idList.g.dart';

@JsonSerializable()

class IdListData {

  List<dynamic>? idList;


  IdListData(
      {
        this.idList,

      });

  factory IdListData.fromJson(Map<String, dynamic> json) =>
      _$IdListDataFromJson(json);

  Map<String, dynamic> toJson() => _$IdListDataToJson(this);



}

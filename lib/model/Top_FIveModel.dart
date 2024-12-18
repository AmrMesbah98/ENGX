import 'package:cloud_firestore/cloud_firestore.dart';

class TopFiveModel {
  String? id;
  String? name;
  String? experience;
  String? address;
  String? image;
  String? email;
  String? skill1;
  String? skill2;
  String? phone;
  List? exp;
  String? linkedin;
  //////////////////////
  String? rateSkAutoCad;
  String? rateSkRevit;
  String? rateSkHvac;
  String? rateSkFirefighting;
  String? rateSkPluming;
  String? rateSkNavisworks;
  String? rateSkDynamo;
  String? rateSkEnScape;

  /////////////////////

  String? rate;
  List<dynamic>? comment;
  List<dynamic>? nameUser;
  List<dynamic>? rateUser;
  dynamic numberUserRate;





  TopFiveModel({
    this.id,
    this.name,
    this.experience,
    this.address,
    this.image,
    this.email,
    this.skill1,
    this.skill2,
    this.phone,
    this.exp,
    this.linkedin,
    /////////////
    this.rateSkAutoCad,
    this.rateSkRevit,
    this.rateSkHvac,
    this.rateSkFirefighting,
    this.rateSkPluming,
    this.rateSkNavisworks,
    this.rateSkDynamo,
    this.rateSkEnScape,
    /////////////////////////////////
    this.rate,
    this.comment,
    this.nameUser,
    this.rateUser,
    this.numberUserRate,


  });

  TopFiveModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    //id = json.data()['id'];
    id = json.id;
    name = json.data()['name'];
    experience = json.data()['experience'];
    address = json.data()['address'];
    image = json.data()['image'];
    email = json.data()['email'];
     skill1 = json.data()['skill1'];
     skill2 = json.data()['skill2'];
    phone = json.data()['phone'];
    exp = json.data()['exp'];
    linkedin = json.data()['linkedin'];
    ///////////////////////
    rateSkAutoCad = json.data()['rateSkAutoCad'];
    rateSkRevit = json.data()['rateSkRevit'];
    rateSkHvac = json.data()['rateSkHvac'];
    rateSkFirefighting = json.data()['rateSkFirefighting'];
    rateSkPluming = json.data()['rateSkPluming'];
    rateSkNavisworks = json.data()['rateSkNavisworks'];
    rateSkDynamo = json.data()['rateSkDynamo'];
    rateSkEnScape = json.data()['rateSkEnScape'];
    ////////////////////////////////////////////
    rate = json.data()['rate'];
    comment = json.data()['comment'];
    nameUser = json.data()['nameUser'];
    rateUser = json.data()['rateUser'];
    numberUserRate = json.data()['numberUserRate'];

  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'experience': experience,
      'address': address,
      'image': image,
      'email': email,
       'skill1': skill1,
       'skill2': skill2,
      'phone': phone,
      'exp': exp,
      'linkedin': linkedin,
      //////////////////
      'rateSkAutoCad': rateSkAutoCad,
      'rateSkRevit': rateSkRevit,
      'rateSkHvac': rateSkHvac,
      'rateSkFirefighting': rateSkFirefighting,
      'rateSkPluming': rateSkPluming,
      'rateSkNavisworks': rateSkNavisworks,
      'rateSkDynamo': rateSkDynamo,
      'rateSkEnScape': rateSkEnScape,
      /////////////////////////
      'rate': rate,
      'comment': comment,
      'nameUser' :nameUser,
      'rateUser' :rateUser,
      'numberUserRate' :numberUserRate,

    };
  }
}


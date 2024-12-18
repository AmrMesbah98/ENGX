import 'dart:convert';
import 'dart:io';

import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/model/CV_Model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import 'package:firebase_storage/firebase_storage.dart';


import '../../firebase_services/firestore_service.dart';
import '../../model/app_user.dart';
import '../../model/get_cv.dart';

part 'user_information_state.dart';

class UserAppInformationCubit extends Cubit<UserInformationState> {
  UserAppInformationCubit(this.firestoreService) : super(UserInformationInitial());

  static UserAppInformationCubit get(context) => BlocProvider.of(context);

  final FireStoreService firestoreService;


  final CollectionReference information =
  FirebaseFirestore.instance.collection('User Application');


  final CollectionReference userApplicationCollection =
  FirebaseFirestore.instance.collection('User Application');



  final CollectionReference cvCollection =
  FirebaseFirestore.instance.collection('CV');

  ApplicationUser? applicationUser;







  Future<void> getInformation() async {
    try{
      //print("${constantvar.idUserOfGoogle}>>>>>>>>>>>>>>>>>>>>>");
      emit(LoadingInformationState());
     firestoreService.getDocSnapshot(uId: FirebaseAuth.instance.currentUser!.uid,collectionReference:information ).listen((value){
        var informationUser = value.data();
         applicationUser = ApplicationUser.fromJson(value.data() as Map<String, dynamic>);
        print("information New is  ---->>>>>>> ${applicationUser!.phone}");
      //  constantvar.updateShowCodeUser = applicationUser!.updateCode;
        print("information is ---->>>>>>> $informationUser");
        emit(SuccsessInformationState());
      });
    }
    catch(error)
    {
      emit(ErrorInformationState());
      debugPrint(error.toString());
    }


  }




  //update

  Future<void> updateInformation(
      {required String id, required Map<String, dynamic> model}) async {
    try {
      emit(LoadingInformationUpdateState());
      await firestoreService.setDoc(
          uId: id, model: model, collectionReference: userApplicationCollection);
      emit(SuccessInformationUpdateState());
    } on FirebaseException catch (error) {
      print(error);
      print(error.code);
      print(error.message);
      emit(ErrorInformationUpdateState());
    }
  }



  File? profileImage;

  var picker = ImagePicker();

  Future <void> getProfileImage()async
  {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(GetProfileImageSuccess());
    }
    else{
      print("No Image is Selected");
      emit(GetProfileImageError());
    }
  }











}

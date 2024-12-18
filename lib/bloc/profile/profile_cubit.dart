import 'package:asec_application/Constant/constant.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../firebase_services/firestore_service.dart';
import '../../model/app_user.dart';
import '../../model/users_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.fireStoreService) : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);

  FireStoreService fireStoreService;

  CollectionReference userCollection =
  FirebaseFirestore.instance.collection("User Application");



  List<UserModel> userList = [];

  ApplicationUser? applicationUser;

  getUsersMsg() async {
    try {
      await FirebaseFirestore.instance
          .collection("User Application")
          .doc(constantvar.uidMsg!)
          .get()
          .then((value) {});
    } catch (e) {
      print(e);
    }
  }


  //get userData

  Future<void> getUserData() async {
    emit(GetUserDataLoading());
    await fireStoreService
        .getCollection(collectionReference: userCollection)
        .then((value) {
      userList = [];
      for (var doc in value.docs) {
        userList.add(UserModel.fromJson(
            doc as QueryDocumentSnapshot<Map<String, dynamic>>));
      }

      emit(GetUserDataSuccess());
    }).catchError((error) {
      emit(GetUserDataError());
      print(error.toString());
    });
  }



  Future<void> getInformation() async {
    try{
      //print("${constantvar.idUserOfGoogle}>>>>>>>>>>>>>>>>>>>>>");
      emit(LoadingInformationState());
      fireStoreService.getDocSnapshot(uId: FirebaseAuth.instance.currentUser!.uid,collectionReference:userCollection ).listen((value){
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



}

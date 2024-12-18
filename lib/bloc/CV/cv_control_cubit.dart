import 'dart:convert';

import 'package:asec_application/model/CV_Model.dart';
import 'package:asec_application/model/myCv.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../firebase_services/firestore_service.dart';
import '../../model/app_user.dart';
import '../../model/cv_model_test.dart';
import '../../model/get_cv.dart';

part 'cv_control_state.dart';

class CvControlCubit extends Cubit<CvControlState> {
  CvControlCubit(this.fireStoreService) : super(CvControlInitial());

  final FireStoreService fireStoreService;

  List<CvModel> cvModelList = [];

  MyCvModel? cvPersonalModel;

  List<CvModelCV> cvModelListCv = [];

  final CollectionReference cvCollection =
      FirebaseFirestore.instance.collection('CV');

  static CvControlCubit get(context) => BlocProvider.of(context);

  Future<void> getCv() async {
    emit(CvControlLoading());
    await fireStoreService
        .getCollection(collectionReference: cvCollection)
        .then((value) {
      cvModelList = [];
      for (var doc in value.docs) {
        cvModelList.add(CvModel.fromJson(
            doc as QueryDocumentSnapshot<Map<String, dynamic>>));
      }

      emit(CvControlSuccess(cvModelList));
    }).catchError((error) {
      print(error.toString());
      emit(CvControlError(error.toString()));
    });
  }

  Future<void> getMyCv() async {
    try {
      emit(GetCvPersonalLoading());

      fireStoreService
          .getDocSnapshot(
              uId: FirebaseAuth.instance.currentUser!.uid,
              collectionReference: cvCollection)
          .listen((value) {

        print("222222222");
        cvPersonalModel = MyCvModel.fromJson(value.data() as Map<String, dynamic> );

        print(cvPersonalModel!.firstname);
        print(cvPersonalModel!.lastname);
        print(cvPersonalModel!.email);
        print(cvPersonalModel!.address);


        print("11111111111111111111111111");print(cvPersonalModel!.addressStNum);

        emit(GetCvPersonalSuccess());
      });
    } catch (error) {
      print(error.toString());
      emit(GetCvPersonalError());
    }
  }

  GetCvModel? cvCubit;

  Future<void> setCv({
    required String firstname,
    required String lastname,
    required String email,
    required String phone,
    required String linkedin,
    required String gpa,
    // required String degreeFinalProject,
    required String graduationYear,
    required String positionCv,
    required String addressStNum,
    required String addressStName,
    required String address,
    required String facebook,
    required String totalLikeCv,
    required String faculty,
    required String startDate,
    required String shareProject,
    required String specialization,
    required String companyName,
    required String state,
    required String military,
    required List pro,
    required bool work,
    required bool isTrain,
    required List listHobbies,
  }) async {
    CvModel cvModel = CvModel(
        firstname: firstname,
        lastname: lastname,
        email: email,
        address: address,
        faculty: faculty,
        phone: phone,
        linkedin: linkedin,
        gpa: gpa,
        graduationYear: graduationYear,
        pro: pro,
        military: military,
        state: state,

        facebook: facebook,
        like: totalLikeCv,
        specialization: specialization,
        companyName: companyName,
        addressStName: addressStName,
        addressStNum: addressStNum,
        positionCv: positionCv,
        shareProject: shareProject,
        startDate: startDate,
        work: work,
        isTrain: isTrain,
        listHobbies: listHobbies);
    try {
      emit(CvControlLoading());
      await fireStoreService
          .setDoc(
              uId: FirebaseAuth.instance.currentUser!.uid,
              model: cvModel.toJson(),
              collectionReference: cvCollection)
          .then((value) {
        print("CV Done Upload");
      });
      emit(CvControlSuccess(cvModelList));
    } catch (error) {
      print(error.toString());
      emit(CvControlError(error.toString()));
    }
  }

  Future<void> editCv({
    required String firstname,
    required String lastname,
    required String email,
    required String phone,
    required String linkedin,
    required String gpa,
    //  required double degreeFinalProject,
    required String graduationYear,
    required String positionCv,
    required String address,
    required String facebook,
    required String totalLikeCv,
    required String faculty,
    required String startDate,
    required String shareProject,
    required String specialization,
    required String companyName,
    required String state,
    required String military,
    required List pro,
  }) async {
    CvModel cvModel = CvModel(
      firstname: firstname,
      lastname: lastname,
      email: email,
      address: address,
      faculty: faculty,
      phone: phone,
      linkedin: linkedin,
      gpa: gpa,
      graduationYear: graduationYear,
      state: state,
      military: military,
      pro: pro,
      facebook: facebook,
      like: totalLikeCv,
      specialization: specialization,
      companyName: companyName,
      positionCv: positionCv,
      shareProject: shareProject,
      startDate: startDate,
    );
    try {
      emit(CvControlLoading());
      await fireStoreService
          .editDoc(
              id: FirebaseAuth.instance.currentUser!.uid,
              model: cvModel.toJson(),
              collectionReference: cvCollection)
          .then((value) {
        print("CV Done Upload");
      });
      emit(CvControlSuccess(cvModelList));
    } catch (error) {
      print(error.toString());
      emit(CvControlError(error.toString()));
    }
  }
}

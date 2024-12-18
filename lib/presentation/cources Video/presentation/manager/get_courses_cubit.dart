import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/shared/components/components.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';


import '../../../../firebase_services/firestore_service.dart';
import '../../data/coursesModel.dart';
import '../../data/innerCategoryModel.dart';
import '../view/firstAllVideoCourses.dart';

part 'get_courses_state.dart';

class GetCoursesVideoCubit extends Cubit<CoursesState> {
  GetCoursesVideoCubit(this.firestoreService) : super(GetCoursesInitial());

  final FireStoreService firestoreService;

  List<VideoCoursesModel> coursesModelList = [];

  final CollectionReference Deletecourses =
  FirebaseFirestore.instance.collection('all courses');

  static GetCoursesVideoCubit get(context) => BlocProvider.of(context);

  final CollectionReference coursesCollection =
  FirebaseFirestore.instance.collection('all video cources');

  final CollectionReference promoCodeCourseCollection =
  FirebaseFirestore.instance.collection('PromoCode Course');

  //////////////////////////////////////////////////////

  Future<void> getVideosCourses() async {
    emit(GetCoursesLoading());
    await firestoreService
        .getCollection(collectionReference: coursesCollection)
        .then((value) {
      coursesModelList = [];
      for (var doc in value.docs) {
        coursesModelList.add(VideoCoursesModel.fromJson(
            doc as QueryDocumentSnapshot<Map<String, dynamic>>));
      }

      emit(GetCoursesSuccess());
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  //////////////////////////////////////////////////////

  List<InnerCategoryModel> innerCategoryList = [];

  Future<dynamic> getSecondCategory(BuildContext context) async {
    try {
      emit(GetInnerCategoryLoading());
      FirebaseFirestore.instance
          .collection("all video cources")
          .doc(constantvar.idCategory)
          .collection("innerCollection")
          .get()
          .then((value) {
        innerCategoryList = [];

        for (var doc in value.docs) {
          innerCategoryList.add(InnerCategoryModel.fromJson(doc));
        }

        emit(GetInnerCategorySuccess());
      }).then((value) {
        navigateTo(
            context,
            FirstAllVideoCourses(
              innerCategoryModel: innerCategoryList,
              id: constantvar.idCategory!,
              promoCode : constantvar.promoCode!,
              nameCourse: constantvar.nameCourse!,
            ));
      });
    } catch (error) {
      print(error);

      emit(GetInnerCategoryError());
    }
  }


//////////////////////////////////////////////////////


//for set user promoCode to see Course

  Future<void> promoCodeCourseFunction(
      {required BuildContext context,
        required String uid,
        required String promoCode,
        required String nameCourse,




      }) async {
    try {

      emit(SetPromoCodeLoading());

      await firestoreService.addDoc(
          model: {
            "uid": uid,
            "promoCode": promoCode,
            "nameCourse": nameCourse,




          }, collectionReference: promoCodeCourseCollection);


      emit( SetPromoCodeSuccess());



    } on FirebaseAuthException catch (e) {
      print(e);
      emit(SetPromoCodeError());
    }
  }


}

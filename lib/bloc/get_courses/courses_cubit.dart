import 'package:asec_application/Constant/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../firebase_services/firestore_service.dart';
import '../../model/courses_model.dart';

part 'courses_state.dart';

class GetCoursesCubit extends Cubit<CoursesState> {
  GetCoursesCubit(this.firestoreService) : super(CoursesInitial());

  final FireStoreService firestoreService;

  List<CoursesModel> coursesModelList = [];

  final CollectionReference Deletecourses =
      FirebaseFirestore.instance.collection('all courses');

  final CollectionReference coursesCollection =
      FirebaseFirestore.instance.collection('all courses');

  static GetCoursesCubit get(context) => BlocProvider.of(context);

  Future<void> getCourses() async {
    emit(GetCoursesLoading());
    // await firestoreService
    //     .getCollection(collectionReference: coursesCollection)
    await FirebaseFirestore.instance
        .collection('all courses')
        .orderBy('rate', descending: true)
        .get()
        .then((value) {
      coursesModelList = [];
      for (var doc in value.docs) {
        coursesModelList.add(CoursesModel.fromJson(
            doc as QueryDocumentSnapshot<Map<String, dynamic>>));
      }

      emit(GetCoursesSuccess(coursesModelList));
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  Future<void> getCoursesSnap() async {
    emit(GetCoursesLoading());
    firestoreService
        .getCollectionSnapshot(collectionReference: coursesCollection)
        .listen((value) {
      coursesModelList = [];
      for (var doc in value.docs) {
        coursesModelList.add(CoursesModel.fromJson(
            doc as QueryDocumentSnapshot<Map<String, dynamic>>));
      }
      emit(GetCoursesSuccess(coursesModelList));
    }).onError((error) {
      emit(GetCoursesFailure(error.toString()));
      debugPrint(error.toString());
    });
  }

  /////////////////////////////////////////////////////

  Future<void> setCoursesSnap({required Map<String, dynamic> data}) async {
    try {
      emit(GetCoursesLoading());
      await firestoreService.addDoc(
          collectionReference: coursesCollection, model: data);
    } catch (error) {
      debugPrint(error.toString());
      emit(GetCoursesFailure(error.toString()));
    }
  }

/////////////////////////////////////////////////////

  Future<void> buildDeleteDocumentFunction(String uid) async {
    try {
      emit(CoursesDeleteLoading());
      await firestoreService.deleteDoc(
          id: uid, collectionReference: Deletecourses);
      emit(CoursesDeleteSuccess());
    } on FirebaseException catch (error) {
      print(error);
      print(error.code);
      print(error.message);
      emit(CoursesDeleteError());
    }
  }

  /////////////////////////////////////////////////////

  Future<void> buildUpdateDocumentFunction(
      {required String id, required Map<String, dynamic> model}) async {
    try {
      emit(UpdateCoursesLoading());
      await firestoreService.editDoc(
          id: id, model: model, collectionReference: coursesCollection);
      emit(UpdateCoursesSuccess());
    } on FirebaseException catch (error) {
      print(error);
      print(error.code);
      print(error.message);
      emit(UpdateCoursesFailure(error.code));
    }
  }

/////////////////////////////////////////////////////

  //rateFunc

  ratingCalculation(
      {required String collectionName,
      required String documentId,
      required double rating,
      required BuildContext context}) async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection(collectionName).doc(documentId);
    print(documentId);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot documentSnapshot =
          await transaction.get(documentReference);

      final lastRatingForTheUser = documentSnapshot.data() as Map;
      String? newRating;
      double? ratingOfUser = double.tryParse(lastRatingForTheUser['rate']);

      if (ratingOfUser == 0.0) {
        newRating = rating.toStringAsFixed(1);
      } else {
        double calculateRating = (ratingOfUser! + rating) / 2;
        newRating = calculateRating.toStringAsFixed(1);
      }

      transaction.update(documentReference, {'rate': newRating});
    }).then((value) {
      GetCoursesCubit.get(context).getCourses();
    });
  }

//////////////////////////////////////////////////////////////////////

  editRateCalculation(
      {required String collectionName,
      required String documentId,
      required double rating,
      required double oldRate,
      required BuildContext context}) async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection(collectionName).doc(documentId);
    print(documentId);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot documentSnapshot =
          await transaction.get(documentReference);

      final lastRatingForTheUser = documentSnapshot.data() as Map;
      String? newRating;
      double? ratingOfUser = double.tryParse(lastRatingForTheUser['rate']);

      if (ratingOfUser == 0.0) {
        newRating = rating.toStringAsFixed(1);
      } else {
        if (oldRate > rating) {
          var x = oldRate - rating;
          // 5         +  2
          constantvar.calculateRatingCourses = (ratingOfUser! + x) / 2;
        } else if (oldRate == rating) {
          constantvar.calculateRatingPackage = ratingOfUser!;
          print("sorry your rate equal to old rate>>>>>>");
        } else {
          var y = rating - oldRate;
          constantvar.calculateRatingCourses = (ratingOfUser! + y) / 2;
        }

        newRating = constantvar.calculateRatingCourses?.toStringAsFixed(1);
      }

      transaction.update(documentReference, {'rate': newRating});
    }).then((value) {
      GetCoursesCubit.get(context).getCourses();
    });
  }

//////////////////////////////////////////////////////////////////////

  addUserNumber() {
    if (constantvar.coursesModel!.rateUser!
        .contains(FirebaseAuth.instance.currentUser!.uid)) {
      print("no add number user rate>>>>>>");
    } else {
      FirebaseFirestore.instance
          .collection('all courses')
          .doc(constantvar.coursesModel!.id)
          .update(
              {'numberUserRate': constantvar.coursesModel!.numberUserRate + 1});
    }
  }
}

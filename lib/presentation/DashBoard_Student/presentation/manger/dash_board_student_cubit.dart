import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../Constant/constant.dart';
import '../../../../firebase_services/firestore_service.dart';
import '../../data/DashBoardModel.dart';
import '../../data/NameInstrctor.dart';
import '../../data/model.dart';

part 'dash_board_student_state.dart';

class DashBoardStudentCubit extends Cubit<DashBoardStudentState> {
  DashBoardStudentCubit(this.fireStoreService)
      : super(DashBoardStudentInitial());
  final FireStoreService fireStoreService;

  List<NameInstructor> nameInstructor = [];

  List<WeekTesterModel> weekTesterModel = [];
  List<WeekTesterModel> weekTesterModelDash = [];
  List<DashBoardModel> dashBoardModel = [];
  List<DashBoardModel> dashBoardModelReview = [];
  List<DashBoardModel> dashBoardModelReviewFilter = [];

  final CollectionReference weekCollection = FirebaseFirestore.instance
      .collection('DashBoard User')
      .doc(constantvar.coderDash)
      .collection("WeekTest");

  final CollectionReference dashboardCollection =
      FirebaseFirestore.instance.collection('DashBoard User');

  final CollectionReference constant =
      FirebaseFirestore.instance.collection('constant');

  static DashBoardStudentCubit get(context) => BlocProvider.of(context);

  ////////////////////////////////////////////////////////////////////
  getDashBoardCollection() async {
    try {
      emit(DashBoardStudentLoading());
      await fireStoreService
          .getCollection(collectionReference: dashboardCollection)
          .then((val) {
        dashBoardModel = [];

        for (var doc in val.docs) {
          dashBoardModel.add(DashBoardModel.fromJson(
              doc as QueryDocumentSnapshot<Map<String, dynamic>>));
        }
        emit(DashBoardStudentSuccess());
      });
    } catch (e) {
      print(e);
      emit(DashBoardStudentError());
    }
  }

  getNameInstructor() async {
    try {
      emit(GetNameInstructorLoading());
      await fireStoreService
          .getCollection(collectionReference: constant)
          .then((val) {
        nameInstructor = [];

        for (var doc in val.docs) {
          nameInstructor.add(NameInstructor.fromJson(
              doc as QueryDocumentSnapshot<Map<String, dynamic>>));
        }
        emit(GetNameInstructorSuccess());
      });
    } catch (e) {
      print(e);
      emit(GetNameInstructorError());
    }
  }

  getWeakCollection() async {
    try {
      emit(DashBoardStudentLoading());

      await FirebaseFirestore.instance
          .collection("DashBoard User")
          .doc(constantvar.coderDash)
          .collection('WeekTest')
          .orderBy('order')
          .get()
          .then((val) {
        weekTesterModel = [];
        for (var doc in val.docs) {
          weekTesterModel.add(WeekTesterModel.fromJson(doc));
        }

        print(weekTesterModel[0].order);
        print(weekTesterModel[1].order);
        print(weekTesterModel[2].order);
      });

      emit(DashBoardStudentSuccess());
    } catch (e) {
      emit(DashBoardStudentError());
      print(e);
      print(e.toString());
    }
  }

////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////

  getWeakCollectionDashboard(String id) async {
    try {
      emit(DashBoardStudentLoadingInnerNew());
      await FirebaseFirestore.instance
          .collection('DashBoard User')
          .doc(id)
          .collection("WeekTest")
          .orderBy('order')
          .get()
          .then((val) {
        weekTesterModelDash = [];
        for (var doc in val.docs) {
          weekTesterModelDash.add(WeekTesterModel.fromJson(
              doc as QueryDocumentSnapshot<Map<String, dynamic>>));
        }
      });

      emit(DashBoardStudentSuccessInnerNew());
    } catch (e) {
      emit(DashBoardStudentErrorInnerNew());
      print(e);
      print(e.toString());
    }
  }

  // for rev circle Avatar
  Future<void> getDashBoardCollectionReview() async {
    try {
      emit(DashBoardStudentLoadingReview());

      await fireStoreService
          .getCollection(collectionReference: dashboardCollection)
          .then((val) {
        dashBoardModelReview = [];
        Set<dynamic> uniqueFieldValues =
            {}; // Set to track unique field values.

        for (var doc in val.docs) {
          var model = DashBoardModel.fromJson(
              doc as QueryDocumentSnapshot<Map<String, dynamic>>);

          // Assuming you're checking for a specific field, e.g., 'fieldName'.
          if (uniqueFieldValues.add(model.instructor)) {
            // Only add the model if its field value is unique.
            dashBoardModelReview.add(model);
          }
        }

        emit(DashBoardStudentSuccessReview());
      });
    } catch (e) {
      print(e);
      emit(DashBoardStudentErrorReview());
    }
  }

  // for rev list of trainer
  Future<void> getDashBoardCollectionReviewFilter(String nameInstructor) async {
    try {
      emit(DashBoardStudentLoadingReviewFilter());

      await FirebaseFirestore.instance
          .collection("DashBoard User")
          .where("instructor", isEqualTo: nameInstructor)
          .get()
          .then((val) {
        dashBoardModelReviewFilter = [];

        for (var doc in val.docs) {
          dashBoardModelReviewFilter.add(DashBoardModel.fromJson(
              doc as QueryDocumentSnapshot<Map<String, dynamic>>));
        }

        emit(DashBoardStudentSuccessReviewFilter());
      });
    } catch (e) {
      print(e);
      emit(DashBoardStudentErrorReviewFilter());
    }
  }

////////////////////////////////////////////////////////////////////
}

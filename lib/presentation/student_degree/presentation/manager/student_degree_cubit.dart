import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../firebase_services/firestore_service.dart';
import '../../data/studentDegree_model.dart';

part 'student_degree_state.dart';

class StudentDegreeCubit extends Cubit<StudentDegreeState> {
  StudentDegreeCubit(this.fireStoreService) : super(StudentDegreeInitial());

  //calling
  static StudentDegreeCubit get(context) => BlocProvider.of(context);
  FireStoreService fireStoreService;

  CollectionReference studentDegreeCollection =
      FirebaseFirestore.instance.collection("student degree");

  CollectionReference reviewInstructorCollection =
      FirebaseFirestore.instance.collection("review instructor");

  List<StudentDegreeModel> studentDegreeList = [];

//////////////////////////////////////////////////////////////////////

  //get Student Degree
  Future<void> getStudentDegree() async {
    emit(GetStudentDegreeLoading());
    await fireStoreService
        .getCollection(collectionReference: studentDegreeCollection)
        .then((value) {
      studentDegreeList = [];
      for (var doc in value.docs) {
        studentDegreeList.add(StudentDegreeModel.fromJson(
            doc as QueryDocumentSnapshot<Map<String, dynamic>>));
      }

      emit(GetStudentDegreeSuccess());
    }).catchError((error) {
      emit(GetStudentDegreeError());
      print(error.toString());
    });
  }

//////////////////////////////////////////////////////////////////////

//add review

  Future<void> addReviewFunction({
    required BuildContext context,
    required String userName,
    required String answerOne,
    required String answerTwo,
    required String answerThree,
    required String grade,
  }) async {
    try {
      await fireStoreService.addDoc(model: {
        "userName": userName,
        "answerOne": answerOne,
        "answerTwo": answerTwo,
        "answerThree": answerThree,
        "grade": grade,
      }, collectionReference: reviewInstructorCollection);
    } catch (e) {
      print(e);
    }
  }

//////////////////////////////////////////////////////////////////////

//add review to Ahmed Yasser
  Future<void> addReviewToAhmedYasserFunction({
    required BuildContext context,
    required String userName,
    required String answerOne,
    required String answerTwo,
    required String answerThree,
    required String grade,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection("review instructor2")
          .doc("Ao5w1Ak4iQ2P7sg0DWvv")
          .collection("innerCollection")
          .add({
        "userName": userName,
        "answerOne": answerOne,
        "answerTwo": answerTwo,
        "answerThree": answerThree,
        "grade": grade,
      });
    } catch (e) {
      print(e);
    }
  }

//////////////////////////////////////////////////////////////////////

//add review To Yousif Yasser
  Future<void> addReviewToYousifYasserFunction({
    required BuildContext context,
    required String userName,
    required String answerOne,
    required String answerTwo,
    required String answerThree,
    required String grade,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection("review instructor2")
          .doc("BuH6TCibOv3146FxKlQX")
          .collection("innerCollection")
          .add({
        "userName": userName,
        "answerOne": answerOne,
        "answerTwo": answerTwo,
        "answerThree": answerThree,
        "grade": grade,
      });
    } catch (e) {
      print(e);
    }
  }

//////////////////////////////////////////////////////////////////////

//add review To Khalid Amin
  Future<void> addReviewToKhalidAminFunction({
    required BuildContext context,
    required String userName,
    required String answerOne,
    required String answerTwo,
    required String answerThree,
    required String grade,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection("review instructor2")
          .doc("CwHPUCN2g4jgyXINoTwc")
          .collection("innerCollection")
          .add({
        "userName": userName,
        "answerOne": answerOne,
        "answerTwo": answerTwo,
        "answerThree": answerThree,
        "grade": grade,
      });
    } catch (e) {
      print(e);
    }
  }
}

/*\


[
Ahemd yasser
amr mesbah
ali ahened
mahmoud

]


select = amr



void selectinstrctor(select)
{

if(select == amr )
{

try {
      await FirebaseFirestore.instance
          .collection("review instructor2")
          .doc("CwHPUCN2g4jgyXINoTwc")
          .collection("innerCollection")
          .add({
        "userName": userName,
        "answerOne": answerOne,
        "answerTwo": answerTwo,
        "answerThree": answerThree,
        "grade": grade,
      });
    } catch (e) {
      print(e);
    }




}


else if(select == amr)
{

try {
      await FirebaseFirestore.instance
          .collection("review instructor2")
          .doc("CwHPUCN2g4jgyXINoTwc")
          .collection("innerCollection")
          .add({
        "userName": userName,
        "answerOne": answerOne,
        "answerTwo": answerTwo,
        "answerThree": answerThree,
        "grade": grade,
      });
    } catch (e) {
      print(e);
    }





}

}




















 */

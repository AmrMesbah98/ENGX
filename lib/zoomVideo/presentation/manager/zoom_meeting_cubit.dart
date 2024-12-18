import 'package:asec_application/Constant/constant.dart';
import 'package:asec_application/shared/components/components.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';


import '../../../firebase_services/firestore_service.dart';
import '../../data/innerQuizModel.dart';
import '../../data/innerZoomMeetingModel.dart';
import '../../data/quizDegreeModel.dart';
import '../../data/zoomMeetingModel.dart';
import '../view/innerQuizPage.dart';
import '../view/innerZoomVideoPage.dart';

part 'zoom_meeting_state.dart';

class ZoomMeetingCubit extends Cubit<ZoomMeetingState> {
  ZoomMeetingCubit(this.fireStoreService) : super(ZoomMeetingInitial());

  final FireStoreService fireStoreService;

  List<ZoomMeetingModel> zoomMeetingList = [];
  List <QuizDegreeModel> quizDegreeList = [];

  final CollectionReference zoomCollection =
  FirebaseFirestore.instance.collection('Zoom Video');

  final CollectionReference getQuizDegree =
  FirebaseFirestore.instance.collection('Quiz Degree');

  static ZoomMeetingCubit get(context) => BlocProvider.of(context);


  Future<void> getZoomMeetingVideo() async {
    emit(ZoomVideoLoading());
    await fireStoreService
        .getCollection(collectionReference: zoomCollection)
        .then((value) {
      zoomMeetingList = [];
      for (var doc in value.docs) {
        zoomMeetingList.add(ZoomMeetingModel.fromJson(
            doc as QueryDocumentSnapshot<Map<String, dynamic>>));


      }

      emit(ZoomVideoSuccess());
    }).catchError((error) {
      emit(ZoomVideoError());
      print(error.toString());
    });
  }


  ///////////////////////////////////////////////


  //////////////////////////////////////////////////////

  List<InnerZoomMeetingModel> innerZoomMeetingList = [];

  Future<dynamic> getSecondCategory(BuildContext context) async {
    try {
      emit(GetInnerZoomMeetingLoading());
      FirebaseFirestore.instance
          .collection("Zoom Video")
          .doc(constantvar.idZoomVideoCategory)
          .collection("innerCollection")
          .get()
          .then((value) {
        innerZoomMeetingList = [];

        for (var doc in value.docs) {
          innerZoomMeetingList.add(InnerZoomMeetingModel.fromJson(doc));
        }

        emit(GetInnerZoomMeetingSuccess());
      }).then((value) {
        navigateTo(
            context,
            InnerZoomVideoPage(
              innerZoomMeetingModel: innerZoomMeetingList,
              id: constantvar.idZoomVideoCategory!,


            ));
      });
    } catch (error) {
      print(error);

      emit(GetInnerZoomMeetingError());
    }
  }


//////////////////////////////////////////////////////


  List<InnerQuizModel> innerQuizList = [];

  Future<dynamic> getInnerQuiz(BuildContext context) async {
    try {
      emit(InnerQuizLoading());
      FirebaseFirestore.instance
          .collection("Zoom Video")
          .doc(constantvar.idCategoryQuiz)
          .collection("innerCollection")
          .get()
          .then((value) {
        innerQuizList = [];

        for (var doc in value.docs) {
          innerQuizList.add(InnerQuizModel.fromJson(doc));
        }

        emit(InnerQuizSuccess());
      }).then((value) {
        navigateTo(
            context,
            InnerQuizPage(
              innerQuizModel: innerQuizList,
              id: constantvar.idCategoryQuiz!,
              title: constantvar.titleCategoryQuiz!,
              //zoomMeetingModel: constantvar.categoryQuiz!,

            ));
      });
    } catch (error) {
      print(error);

      emit(InnerQuizError());
    }
  }



///////////////////////////////////////////////


//for set quiz degree

  Future<void> setQuizDegreeFunction(
      {
        required String name,
        required String degree,
        required String quiz,

      }) async {
    try {
      emit(QuizDegreeLoading());
      await fireStoreService.addDoc(
          model: {
            "name": name,
            "degree": degree,
            "quiz": quiz,

          }, collectionReference: getQuizDegree);

      emit(QuizDegreeSuccess());
    } catch (e) {
      print(e);
      emit(QuizDegreeError());
    }
  }

///////////////////////////////////////////////


  //for get quiz degree to dashboard

  Future<void> getQuizDegreeFunction() async {
    emit(GetQuizDegreeLoading());
    await fireStoreService
        .getCollection(collectionReference: getQuizDegree)
        .then((value) {
      quizDegreeList = [];
      for (var doc in value.docs) {
        quizDegreeList.add(QuizDegreeModel.fromJson(
            doc as QueryDocumentSnapshot<Map<String, dynamic>>));
      }

      emit(GetQuizDegreeSuccess());
    }).catchError((error) {
      emit(GetQuizDegreeError());
      print(error.toString());
    });
  }


}

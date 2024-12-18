import 'package:asec_application/model/quiz_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../firebase_services/firestore_service.dart';
import '../../model/getQuizDegree_model.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit(this.fireStoreService) : super(QuizInitial());


  final FireStoreService fireStoreService;

  static QuizCubit get(context) => BlocProvider.of(context);


  final CollectionReference getQuiz =
  FirebaseFirestore.instance.collection('Quiz');

  // final CollectionReference getQuizDegree =
  // FirebaseFirestore.instance.collection('Quiz Degree');

  List <QuizModel> quizList = [];

  List <QuizDegreeModel> quizDegreeList = [];

  //////////////////////////////////////////////////////////

//for get quiz (question and mcq)
  Future<void> getQuizFunction() async {
    emit(QuizLoading());
    await fireStoreService
        .getCollection(collectionReference: getQuiz)
        .then((value) {
      quizList = [];
      for (var doc in value.docs) {
        quizList.add(QuizModel.fromJson(
            doc as QueryDocumentSnapshot<Map<String, dynamic>>));
      }

      emit(QuizSuccess());
    }).catchError((error) {
      emit(QuizError());
      print(error.toString());
    });
  }

//////////////////////////////////////////////////////////

//for set quiz degree

  // Future<void> setQuizDegreeFunction(
  //     {
  //       required String name,
  //       required String degree,
  //       required String quiz,
  //
  //     }) async {
  //   try {
  //     emit(QuizDegreeLoading());
  //     await fireStoreService.addDoc(
  //         model: {
  //           "name": name,
  //           "degree": degree,
  //           "quiz": quiz,
  //
  //         }, collectionReference: getQuizDegree);
  //
  //     emit(QuizDegreeSuccess());
  //   } catch (e) {
  //     print(e);
  //     emit(QuizDegreeError());
  //   }
  // }


//////////////////////////////////////////////////////////

//for get quiz degree to dashboard
//
//   Future<void> getQuizDegreeFunction() async {
//     emit(GetQuizDegreeLoading());
//     await fireStoreService
//         .getCollection(collectionReference: getQuizDegree)
//         .then((value) {
//       quizDegreeList = [];
//       for (var doc in value.docs) {
//         quizDegreeList.add(QuizDegreeModel.fromJson(
//             doc as QueryDocumentSnapshot<Map<String, dynamic>>));
//       }
//
//       emit(GetQuizDegreeSuccess());
//     }).catchError((error) {
//       emit(GetQuizDegreeError());
//       print(error.toString());
//     });
//   }

//////////////////////////////////////////////////////////

}

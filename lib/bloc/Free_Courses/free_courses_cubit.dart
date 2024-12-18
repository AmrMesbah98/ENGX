import 'package:asec_application/Constant/constant.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../firebase_services/firestore_service.dart';
import '../../model/free_courses_model/free_courses_model.dart';
import '../../model/free_courses_model/inner_free_courses_model.dart';
import '../../presentation/Free_Courses/innerFreeCouses.dart';
import '../../shared/components/components.dart';

part 'free_courses_state.dart';

class FreeCoursesCubit extends Cubit<FreeCoursesState> {
  FreeCoursesCubit(this.fireStoreService) : super(FreeCoursesInitial());


  final FireStoreService fireStoreService;

  List<FreeCoursesModel> freeCoursesList = [];
  List <InnerFreeCoursesModel> innerFreeCoursesList = [];

  final CollectionReference freeCoursesCollection =
  FirebaseFirestore.instance.collection('Free Courses');



  static FreeCoursesCubit get(context) => BlocProvider.of(context);


  Future<void> getFreeCoursesVideo() async {
    emit(GetFreeCoursesLoading());
    // await fireStoreService
    //     .getCollection(collectionReference: freeCoursesCollection)
    await FirebaseFirestore.instance.collection("Free Courses").orderBy("rate" , descending: true).get()
        .then((value) {
      freeCoursesList = [];
      for (var doc in value.docs) {
        freeCoursesList.add(FreeCoursesModel.fromJson(
            doc as QueryDocumentSnapshot<Map<String, dynamic>>));


      }

      emit(GetFreeCoursesSuccess());
    }).catchError((error) {
      emit(GetFreeCoursesError(error.toString()));
      print(error.toString());
    });
  }




  //////////////////////////////////////////////////////



  Future<dynamic> getSecondCategory(BuildContext context) async {
    try {
      emit(GetInnerFreeCoursesLoading());
      FirebaseFirestore.instance
          .collection("Free Courses")
          .doc(constantvar.idFreeCoursesCategory)
          .collection("innerCollection")
          .get()
          .then((value) {
        innerFreeCoursesList = [];

        for (var doc in value.docs) {
          innerFreeCoursesList.add(InnerFreeCoursesModel.fromJson(doc));
        }


      })
          .then((value) {
        navigateTo(
            context,
            InnerFreeCoursesPage(
              innerFreeCoursesModel: innerFreeCoursesList,
              id: constantvar.idFreeCoursesCategory!,
              freeCoursesModel:  constantvar.freeCoursesModel!,

            ));
      }
      );
      emit(GetInnerFreeCoursesSuccess());
    } catch (error) {
      print(error);

      emit(GetInnerFreeCoursesError());
    }
  }


//////////////////////////////////////////////////////


//rateFunc

  ratingCalculation( {required String collectionName , required String documentId , required double rating,required BuildContext context}
      ) async {
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

      FreeCoursesCubit.get(context).getFreeCoursesVideo();

    });
  }

//////////////////////////////////////////////////////////////////////

  editRateCalculation(
      {required String collectionName,
        required String documentId,
        required double rating,
        required double oldRate,
        required BuildContext context
      }

      ) async {

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
        if(oldRate>rating)
        {
          var x = oldRate-rating;
          // 5         +  2
          constantvar.calculateRatingFreeCourses = (ratingOfUser! +  x  ) / 2;
        }
        else if(oldRate==rating)
        {
          constantvar.calculateRatingFreeCourses=ratingOfUser!;
          print("sorry your rate equal to old rate>>>>>>");
        }
        else
        {
          var y = rating-oldRate;
          constantvar.calculateRatingFreeCourses = (ratingOfUser! + y  ) / 2;
        }


        newRating = constantvar.calculateRatingFreeCourses?.toStringAsFixed(1);
      }

      transaction.update(documentReference, {'rate': newRating});
    }).then((value) {

      FreeCoursesCubit.get(context).getFreeCoursesVideo();

    });



  }

//////////////////////////////////////////////////////////////////////

  addUserNumber(){
    if(constantvar.freeCoursesModel!.rateUser!.contains(FirebaseAuth.instance.currentUser!.uid)){
      print("no add number user rate>>>>>>");
    }
    else{
      FirebaseFirestore.instance.collection('Free Courses').doc( constantvar.freeCoursesModel!.id).update(
          {
            'numberUserRate':constantvar.freeCoursesModel!.numberUserRate +1
          });
    }

  }


}

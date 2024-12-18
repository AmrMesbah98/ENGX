import 'package:asec_application/Constant/constant.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../firebase_services/firestore_service.dart';
import '../../model/instructor_model.dart';

part 'get_instructor_state.dart';

class GetInstructorCubit extends Cubit<GetInstructorState> {
  GetInstructorCubit(this.firestoreService) : super(GetInstructorInitial());

  final FireStoreService firestoreService;

  static GetInstructorCubit get(context) => BlocProvider.of(context);

  List<InstructorModel> userModelList = [];

  final CollectionReference Instructorcollection =
      FirebaseFirestore.instance.collection('all Instructor');

  Future<void> geInstructor() async {
    emit(GetInstructorLoading());
    // await firestoreService
    //     .getCollection(collectionReference: Instructorcollection)


    await FirebaseFirestore.instance
        .collection('all Instructor')
        .orderBy('rate', descending: true)
        .get()
        .then((value) {
      userModelList = [];
      for (var doc in value.docs) {
        userModelList.add(InstructorModel.fromJson(
            doc as QueryDocumentSnapshot<Map<String, dynamic>>));
      }
      emit(GetInstructorSuccess(userModelList));
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  /*
  Future<void> getInstructorSnap() async {
    emit(GetInstructorLoading());
    firestoreService
        .getCollectionSnapshot(collectionReference: Instructorcollection)
        .listen((value) {
      userModelList = [];
      for (var doc in value.docs) {
        userModelList.add(InstructorModel.fromJson(
            doc as QueryDocumentSnapshot<Map<String, dynamic>>));
      }
      emit(GetInstructorSuccess(userModelList));
    }).onError((error) {
      emit(GetInstructorFailure(error.toString()));
      debugPrint(error.toString());
    });
  }

   */

  //////////////////////////////////////////////////////////////////////

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

      GetInstructorCubit.get(context).geInstructor();

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
            constantvar.calculateRating = (ratingOfUser! +  x  ) / 2;
          }
        else if(oldRate==rating)
        {
          constantvar.calculateRatingPackage=ratingOfUser!;
          print("sorry your rate equal to old rate>>>>>>");
        }
        else
          {
            var y = rating-oldRate;
            constantvar.calculateRating = (ratingOfUser! + y  ) / 2;
          }


        newRating = constantvar.calculateRating?.toStringAsFixed(1);
      }

      transaction.update(documentReference, {'rate': newRating});
    }).then((value) {

      GetInstructorCubit.get(context).geInstructor();

    });



  }

  //////////////////////////////////////////////////////////////////////

  addUserNumber(){
    if(constantvar.instructorModel!.rateUser!.contains(FirebaseAuth.instance.currentUser!.uid)){
      print("no add number user rate>>>>>>");
    }
    else{
      FirebaseFirestore.instance.collection('all Instructor').doc(constantvar.instructorModel!.id).update(
          {
            'numberUserRate':constantvar.instructorModel!.numberUserRate +1
          }).then((value) {
        print("add number user rate done>>>>");
      });
    }
  }






}

//////////////////////////////////////////////////////////////

//rateFunc default

/*

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

    GetCoursesCubit.get(context).getCourses();

  });
}


 */

import 'package:asec_application/Constant/constant.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../firebase_services/firestore_service.dart';
import '../../model/package_courses.dart';
import '../get_courses/courses_cubit.dart';

part 'get_package_state.dart';

class GetPackageCubit extends Cubit<GetPackageState> {
  GetPackageCubit(this.fireStoreService) : super(GetPackageInitial());

  final FireStoreService fireStoreService;
  List<PackageCourses> packageCoursesList = [];
  final CollectionReference getPackage =
      FirebaseFirestore.instance.collection('package');

  static GetPackageCubit get(context) => BlocProvider.of(context);

  Future<void> getPackdgeFunction() async {
    emit(GetPackageLoading());
    await fireStoreService
        .getCollection(collectionReference: getPackage)
        .then((value) {
      packageCoursesList = [];
      for (var doc in value.docs) {
        packageCoursesList.add(PackageCourses.fromJson(
            doc as QueryDocumentSnapshot<Map<String, dynamic>>));
      }

      emit(GetPackageSuccess(packageCoursesList));
    }).catchError((error) {
      print(error.toString());
    });
  }

  /////////////////////////////////////////////////////


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

      GetCoursesCubit.get(context).getCourses();

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
          constantvar.calculateRatingPackage = (ratingOfUser! +  x  ) / 2;
        }
        else if(oldRate==rating)
        {
          constantvar.calculateRatingPackage=ratingOfUser!;
          print("sorry your rate equal to old rate>>>>>>");
        }
        else
        {
          var y = rating-oldRate;
          constantvar.calculateRatingPackage = (ratingOfUser! + y  ) / 2;
        }


        newRating = constantvar.calculateRatingPackage?.toStringAsFixed(1);
      }

      transaction.update(documentReference, {'rate': newRating});
    }).then((value) {

      GetPackageCubit.get(context).getPackdgeFunction();

    });



  }

//////////////////////////////////////////////////////////////////////

  addUserNumber(){
    if(constantvar.packageCoursesModel!.rateUser!.contains(FirebaseAuth.instance.currentUser!.uid)){
      print("no add number user rate >>>>>>");
    }
    else{
      FirebaseFirestore.instance.collection('package').doc(constantvar.packageCoursesModel!.id).update(
          {
            'numberUserRate':constantvar.packageCoursesModel!.numberUserRate +1
          }).then((value) {
        print("add number user rate done>>>>");
      });
    }
  }


}

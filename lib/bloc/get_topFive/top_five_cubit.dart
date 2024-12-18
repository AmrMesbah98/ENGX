import 'package:asec_application/Constant/constant.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../firebase_services/firestore_service.dart';
import '../../model/Top_FIveModel.dart';



part 'top_five_state.dart';

class GetTopFiveCubit extends Cubit<TopFiveState> {
  GetTopFiveCubit(this.fireStoreService) : super(TopFiveInitial());

  static GetTopFiveCubit get(context) => BlocProvider.of(context);

  final FireStoreService fireStoreService;

  final CollectionReference TopFiveCollection =
  FirebaseFirestore.instance.collection('Top Five');

  List<TopFiveModel> TopFiveList=[];
  Future<void> getTopFiveSnap() async {
    try
        {
          emit(LoadingTopFiveState());
          //fireStoreService.getCollection(collectionReference:TopFiveCollection )
          await FirebaseFirestore.instance
              .collection('Top Five')
              .orderBy('rate', descending: true)
              .get()
              .then((value){
            TopFiveList=[];
            for(var doc in value.docs){
              TopFiveList.add(TopFiveModel.fromJson(doc as QueryDocumentSnapshot<Map<String, dynamic>> ));
            }
            emit(SuccessTopFiveState(TopFiveList));
          });


        }
        catch(e)
    {
      print(e);
      emit(ErrorTopFiveState(e.toString()));
    }
  }


  ///////////////////////////////////////////////////////////////


//rateFunc

  ratingCalculation( {required String collectionName , required String documentId , required double rating,required BuildContext context}
      ) async {

    DocumentReference documentReference =FirebaseFirestore.instance.collection(collectionName).doc(documentId);

    print(documentId);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot documentSnapshot = await transaction.get(documentReference);

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

      GetTopFiveCubit.get(context).getTopFiveSnap();

    });
  }





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
          constantvar.calculateRatingTopFive = (ratingOfUser! +  x  ) / 2;
        }
        else if(oldRate==rating)
        {
          constantvar.calculateRatingPackage=ratingOfUser!;
          print("sorry your rate equal to old rate>>>>>>");
        }
        else
        {
          var y =rating-oldRate;
          constantvar.calculateRatingTopFive = (ratingOfUser! + y  ) / 2;
        }


        newRating = constantvar.calculateRatingTopFive?.toStringAsFixed(1);
      }

      transaction.update(documentReference, {'rate': newRating});
    }).then((value) {

      GetTopFiveCubit.get(context).getTopFiveSnap();

    });



  }


////////////////////////////////////////////////////////////

//add user number

addUserNumber(){


    if(constantvar.topFiveModel!.rateUser!.contains(FirebaseAuth.instance.currentUser!.uid)){
      print("no add number user rate>>>>>>");
    }
    else{
      FirebaseFirestore.instance.collection('Top Five').doc(constantvar.topFiveModel!.id).update(
          {
            'numberUserRate':constantvar.topFiveModel!.numberUserRate +1
          }).then((value) {
        print("add number user rate done>>>>");
      });
    }

}




}



/*
  Future<void> getTopFiveSnap() async {
    emit(LoadingTopFiveState());
    fireStoreService.getCollectionSnapshot(collectionReference:TopFiveCollection ).listen((value){
      TopFiveList=[];
      for(var doc in value.docs){
        TopFiveList.add(TopFiveModel.fromJson(doc as QueryDocumentSnapshot<Map<String, dynamic>> ));
      }
      emit(SuccessTopFiveState(TopFiveList));
    }).onError((error){
      emit(ErrorTopFiveState(error.toString()));
      debugPrint(error.toString());
    });
  }
 */

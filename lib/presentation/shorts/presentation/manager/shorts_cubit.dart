import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../firebase_services/firestore_service.dart';
import '../../data/shorts_model.dart';


part 'shorts_state.dart';

class ShortsCubit extends Cubit<ShortsState> {
  ShortsCubit(this.fireStoreService) : super(ShortsInitial());


  //calling
  static ShortsCubit get(context) => BlocProvider.of(context);
  FireStoreService fireStoreService;

  CollectionReference shortsCollection =
  FirebaseFirestore.instance.collection("Shorts");

  List<ShortsModel> shortsList=[];

//////////////////////////////////////////////////////////////////////


  //get  shorts videos
  Future<void> getShortsVideos() async {
    emit(GetShortsVideosLoading());
    await fireStoreService
        .getCollection(collectionReference: shortsCollection)
        .then((value) {
      shortsList = [];
      for (var doc in value.docs) {
        shortsList.add(ShortsModel.fromJson(
            doc as QueryDocumentSnapshot<Map<String, dynamic>>));
      }

      emit(GetShortsVideosSuccess());
    }).catchError((error) {
      emit(GetShortsVideosError());
      print(error.toString());
    });
  }

//////////////////////////////////////////////////////////////////////


}

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../firebase_services/firestore_service.dart';
import '../../model/post_model.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit(this.fireStoreService) : super(PostInitial());



  final FireStoreService fireStoreService;

  final CollectionReference postCollection =
  FirebaseFirestore.instance.collection('Post');

  final CollectionReference postViewCollection =
  FirebaseFirestore.instance.collection('PostView');



  static PostCubit get(context) => BlocProvider.of(context);


  List<PostModel> modelPost = [];

  List<PostModel> finalPost = [];

  Future<void> getPostFunction() async {
    emit(GetPostLoading());
    await fireStoreService
        .getCollection(collectionReference: postCollection)
        .then((value) {

      modelPost = [] ;
      for (var doc in value.docs) {
        modelPost.add(PostModel.fromJson(
            doc as QueryDocumentSnapshot<Map<String, dynamic>>));
        print(modelPost);
      }

      emit(GetPostSuccess());
    }).catchError((error) {
      emit(GetPostError());
      print(error.toString());
    });
  }

  Future<void> getFinalPostFunction() async {
    emit(GetPostLoading());
    await fireStoreService
        .getCollection(collectionReference: postViewCollection)
        .then((value) {

      finalPost = [] ;
      for (var doc in value.docs) {
        finalPost.add(PostModel.fromJson(
            doc as QueryDocumentSnapshot<Map<String, dynamic>>));
        print(finalPost);
      }

      emit(GetPostSuccess());
    }).catchError((error) {
      emit(GetPostError());
      print(error.toString());
    });
  }


  Future<void> setPostFunction({required Map<String, dynamic> data, required String uid}) async {

    try{
      emit(SetPostLoading());
      await fireStoreService
          .setDoc(collectionReference: postCollection, model: data, uId:uid ).then((value){

            print("Post is Done");
            emit(SetPostSuccess());

      });

    }
    catch(error)
    {
      debugPrint(error.toString());
      emit(SetPostError());
    }
  }


  Future<void> setPostFunctionAfterTest({required Map<String, dynamic> data,}) async {

    try{
      emit(SetPostLoading());
      await fireStoreService
          .addDoc(collectionReference: postViewCollection, model: data, ).then((value)  {

        print("Post View is Done");
        emit(SetPostSuccess());

      });

    }
    catch(error)
    {
      debugPrint(error.toString());
      emit(SetPostError());
    }
  }









}

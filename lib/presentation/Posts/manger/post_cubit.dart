// import 'package:bloc/bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:meta/meta.dart';
//
// import '../../../firebase_services/firestore_service.dart';
// import '../../../model/post_model.dart';
// import '../data/CreatePostModel.dart';
//
// part 'post_state.dart';
//
// class PostCubit extends Cubit<PostState> {
//   PostCubit(this.fireStoreService) : super(PostInitial());
//
//   static PostCubit get(context) => BlocProvider.of(context);
//
//   final FireStoreService fireStoreService;
//
//   final CollectionReference postCollection =
//       FirebaseFirestore.instance.collection('post');
//
//
//   Future<void> setPost({
//     required String postTitle,
//     required String postDescription,
//     required String comment,
//     required bool isShow,
//   }) async {
//     PostModel postModel = PostModel(
//       postTitle: postTitle,
//       postDescription: postDescription,
//       comment: comment,
//       isShow: isShow,
//     );
//
//     try {
//       emit(CreatePostLoading());
//
//       await fireStoreService
//           .setDoc(
//               collectionReference: postCollection,
//               model: postModel.toJson(),
//               uId: FirebaseAuth.instance.currentUser!.uid)
//           .then((value) {
//         print("Post Upload");
//       });
//
//       emit(CreatePostSuccess());
//     } catch (error) {
//       debugPrint(error.toString());
//       emit(CreatePostError());
//     }
//   }
// }

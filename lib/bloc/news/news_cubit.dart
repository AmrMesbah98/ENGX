import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../firebase_services/firestore_service.dart';
import '../../model/news_model.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit(this.fireStoreService) : super(NewsInitial());
  final FireStoreService fireStoreService;

  static NewsCubit get(context) => BlocProvider.of(context);

  final CollectionReference news =
      FirebaseFirestore.instance.collection('NewsCorner');

  List<NewsModel> newsModel = [];

  getNews() {
    try {
      emit(GetNewsLoading());

      fireStoreService.getCollection(collectionReference: news).then((value) {
        newsModel = [];

        for (var doc in value.docs) {
          newsModel.add(NewsModel.fromJson(
              doc as QueryDocumentSnapshot<Map<String, dynamic>>));
        }

        emit(GetNewsSuccess());
      });
    } catch (error) {
      print(error);
      emit(GetNewsError());
    }
  }

  Future<dynamic> setNews(
      {required String title,
      required String description,
      required String date}) async {
    NewsModel newsModel =
        NewsModel(title: title, description: description, date: date);
    try {
      emit(SetNewsLoading());
      await fireStoreService.addDoc(
          collectionReference: news, model: newsModel.toJson());
      emit(SetNewsSuccess());

      print("News is uploaded");
    } catch (error) {
      print(error);
      emit(SetNewsError());
    }
  }
}

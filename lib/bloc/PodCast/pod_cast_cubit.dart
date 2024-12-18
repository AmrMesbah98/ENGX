import 'package:asec_application/model/podCast_Model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../firebase_services/firestore_service.dart';

part 'pod_cast_state.dart';

class PodCastCubit extends Cubit<PodCastState> {
  PodCastCubit(this.fireStoreService) : super(PodCastInitial());


  final FireStoreService fireStoreService;

  List<PodCastModel> podCastList = [];

  final CollectionReference getPartners =
  FirebaseFirestore.instance.collection('PoadCast');

  static PodCastCubit get(context) => BlocProvider.of(context);


  Future<void> getPodCast() async {
    emit(PodCastLoading());
    await fireStoreService
        .getCollection(collectionReference: getPartners)
        .then((value) {
      podCastList = [];
      for (var doc in value.docs) {
        podCastList.add(PodCastModel.fromJson(
            doc as QueryDocumentSnapshot<Map<String, dynamic>>));
      }

      emit(PodCastSuccess());
    }).catchError((error) {
      emit(PodCastError());
      print(error.toString());
    });
  }




}

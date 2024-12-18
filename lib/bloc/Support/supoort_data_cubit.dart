import 'package:asec_application/firebase_services/firestore_service.dart';
import 'package:asec_application/model/supportModel.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'supoort_data_state.dart';

class SupoortDataCubit extends Cubit<SupoortDataState> {
  SupoortDataCubit(this.fireStoreService) : super(SupportDataInitial());

  FireStoreService fireStoreService;

  static SupoortDataCubit get(context) => BlocProvider.of(context);

  CollectionReference support =
      FirebaseFirestore.instance.collection('Support');

  List<ModelSupport> model = [];

  Future getSupportData() async {
    try {
      emit(SupoortDataLoading());

      await fireStoreService
          .getCollection(collectionReference: support)
          .then((value) {
        model = [];

        for (var doc in value.docs) {
          model.add(ModelSupport.fromJson(
              doc as QueryDocumentSnapshot<Map<String, dynamic>>));
        }
      });

      emit(SupoortDataSuccess());
    } catch (e) {
      print(e);

      emit(SupoortDataError());
    }
  }
}

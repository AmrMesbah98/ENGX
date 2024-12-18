import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../firebase_services/firestore_service.dart';
import '../../model/Partners_Model.dart';

part 'partners_state.dart';

class PartnersCubit extends Cubit<PartnersState> {
  PartnersCubit(this.fireStoreService) : super(PartnersInitial());


  final FireStoreService fireStoreService;

  List<Partners> partnersList = [];

  final CollectionReference getPartners =
  FirebaseFirestore.instance.collection('Partners');

  static PartnersCubit get(context) => BlocProvider.of(context);



  Future<void> getPartner() async {
    emit(PartnersLoading());
    await fireStoreService
        .getCollection(collectionReference: getPartners)
        .then((value) {
      partnersList = [];
      for (var doc in value.docs) {
        partnersList.add(Partners.fromJson(
            doc as QueryDocumentSnapshot<Map<String, dynamic>>));
      }

      emit(PartnersSuccess(partnersList));
    }).catchError((error) {
      emit(PartnersError(error.toString()));
      print(error.toString());
    });
  }
}

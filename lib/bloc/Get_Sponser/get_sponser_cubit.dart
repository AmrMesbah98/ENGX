import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../firebase_services/firestore_service.dart';
import '../../model/sponser_model.dart';

part 'get_sponser_state.dart';

class GetSponserCubit extends Cubit<GetSponserState> {
  GetSponserCubit(this.fireStoreService) : super(GetSponserInitial());


  final FireStoreService fireStoreService;

  List<Sponser> SponserList = [];

  final CollectionReference getPartners =
  FirebaseFirestore.instance.collection('Sponser');

  static GetSponserCubit get(context) => BlocProvider.of(context);



  Future<void> getSponser() async {
    emit(GetSponserLoading());
    await fireStoreService
        .getCollection(collectionReference: getPartners)
        .then((value) {
      SponserList = [];
      for (var doc in value.docs) {
        SponserList.add(Sponser.fromJson(
            doc as QueryDocumentSnapshot<Map<String, dynamic>>));
      }

      emit(GetSponserSuccess(SponserList));
    }).catchError((error) {
      emit(GetSponserError(error.toString()));
      print(error.toString());
    });
  }

}

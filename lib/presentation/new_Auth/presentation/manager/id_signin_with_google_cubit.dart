import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../firebase_services/firestore_service.dart';
import '../../data/idList_model.dart';

part 'id_signin_with_google_state.dart';

class IdSigninWithGoogleCubit extends Cubit<IdSigninWithGoogleState> {
  IdSigninWithGoogleCubit(this.fireStoreService) : super(IdSigninWithGoogleInitial());

  static IdSigninWithGoogleCubit get(context) => BlocProvider.of(context);
  final FireStoreService fireStoreService;


  final CollectionReference idCollection =
  FirebaseFirestore.instance.collection('User With Google');


  IdListModel? idListData;


  Future<void> getId() async {
    try {
      emit(IdSigninWithGoogleLoading());

      fireStoreService
          .getDocSnapshot(
          uId: "IAQ2iUMDHFsLPOlw2h9Z",
          collectionReference: idCollection)
          .listen((value) {

        idListData = IdListModel.fromJson(value.data() as Map<String, dynamic> );

        print("my length is ========>>>>> ${idListData!.idList!.length}");


        emit(IdSigninWithGoogleSuccess());
      });
    } catch (error) {
      print(error.toString());
      emit(IdSigninWithGoogleError());
    }
  }

}

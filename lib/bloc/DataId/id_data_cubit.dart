import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../firebase_services/firestore_service.dart';
import '../../model/idList.dart';

part 'id_data_state.dart';

class IdDataCubit extends Cubit<IdDataState> {
  IdDataCubit(this.fireStoreService) : super(IdDataInitial());

  static IdDataCubit get(context) => BlocProvider.of(context);
  final FireStoreService fireStoreService;


  final CollectionReference idCollection =
  FirebaseFirestore.instance.collection('check');


  IdListData? idListData;


  Future<void> getId() async {
    try {
      emit(IdDataLoading());

      fireStoreService
          .getDocSnapshot(
          uId: "2VCKA0ejOAwI7o5qxeOn",
          collectionReference: idCollection)
          .listen((value) {

        print("222222222");
        idListData = IdListData.fromJson(value.data() as Map<String, dynamic> );

        print("my length is ========>>>>> ${idListData!.idList!.length}");



        print("11111111111111111111111111");

        emit(IdDataSuccess());
      });
    } catch (error) {
      print(error.toString());
      emit(IdDataError());
    }
  }
}

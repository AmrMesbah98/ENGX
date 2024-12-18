import 'package:asec_application/Constant/constant.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../firebase_services/firestore_service.dart';
import '../../model/updateCOde.dart';

part 'code_update_state.dart';

class CodeUpdateCubit extends Cubit<CodeUpdateState> {
  CodeUpdateCubit(this.fireStoreService) : super(CodeUpdateInitial());

  static CodeUpdateCubit get(context) => BlocProvider.of(context);

  final FireStoreService fireStoreService;

  final CollectionReference getCodeUpdate =
      FirebaseFirestore.instance.collection('Update Code');

  CodeUpdateModel? codeUpdateModel;

  Future<void> getCodeUpdateFunction() async {
    emit(CodeUpdateLoading());
    try {
      await fireStoreService
          .getDoc(
              uId: "MStPDRa4aP2vCasCRRd7", collectionReference: getCodeUpdate)
          .then((value) {

        var informationUser = value.data();

        print(informationUser);

        codeUpdateModel=  CodeUpdateModel.fromJson(informationUser as Map<String, dynamic>);


        print(" Code update is  ${codeUpdateModel!.codeUpdate}");

        constantvar.updateShowCode = codeUpdateModel!.codeUpdate!;
      });

      emit(CodeUpdateSuccess());
    } catch (error) {
      print(error.toString());
      emit(CodeUpdateError());
    }
  }
}

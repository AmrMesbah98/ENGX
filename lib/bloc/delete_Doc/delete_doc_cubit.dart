import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../firebase_services/firestore_service.dart';

part 'delete_doc_state.dart';

class DeleteDocCubit extends Cubit<DeleteDocState> {
  DeleteDocCubit(this.firestoreService) : super(DeleteDocInitial());

  final FireStoreService firestoreService;


  static DeleteDocCubit get(context) => BlocProvider.of(context);


  final CollectionReference DeleteDocument =
  FirebaseFirestore.instance.collection('Application User');
//delete
  Future<void> buildDeleteDocumentFunction(String Uid)
  async {
    try
    {
      emit(DeleteDocLoading());
      await firestoreService.deleteDoc(id: Uid, collectionReference: DeleteDocument);
      emit(DeleteDocSuccess());
    }
    on FirebaseException catch(error)
    {
      print(error);
      print(error.code);
      print(error.message);
      emit(DeleteDocError());
    }
  }

}

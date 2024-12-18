import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../firebase_services/firestore_service.dart';
import '../../model/project_model.dart';

part 'project_state.dart';

class ProjectCubit extends Cubit<ProjectState> {
  ProjectCubit(this.firestoreService) : super(ProjectInitial());


  static ProjectCubit get(context) => BlocProvider.of(context);



  final FireStoreService firestoreService;
  List<ProjectModel> projectModelList=[];

  final CollectionReference projectCollection =
  FirebaseFirestore.instance.collection('all project');

  Future<void> getProject() async {
    emit(GetProjectLoading());
    await firestoreService.getCollection(collectionReference: projectCollection).then((value){
      projectModelList=[];
      for(var doc in value.docs){
        projectModelList.add(ProjectModel.fromJson(doc as QueryDocumentSnapshot<Map<String, dynamic>> ));
      }
      emit(GetProjectSuccess(projectModelList));
    }).catchError((error){
      debugPrint(error.toString());
      emit(GetProjectFailure(error.toString()));
    });
  }



  Future<void> getProjectSnap() async {
    emit(GetProjectLoading());
    firestoreService.getCollectionSnapshot(collectionReference:projectCollection ).listen((value){
      projectModelList=[];
      for(var doc in value.docs){
        projectModelList.add(ProjectModel.fromJson(doc as QueryDocumentSnapshot<Map<String, dynamic>> ));
      }
      emit(GetProjectSuccess(projectModelList));
    }).onError((error){
      emit(GetProjectFailure(error.toString()));
      debugPrint(error.toString());
    });
  }


  Future<void> setProject({required Map<String, dynamic> data,}) async {

    try {
      emit(SetProjectLoading());
      await firestoreService.addDoc(
          collectionReference: projectCollection, model:data,);
      emit(SetProjectSuccess());
    }
     on FirebaseException  catch(error)
    {
      print(error);
      print(error.code);
      print(error.message);
      emit(SetProjectFailure());
    }



  }



  Future<void> buildUpdateDocumentFunction(
      {required String id, required Map<String, dynamic> model}) async {
    try {
      emit(UpdateProjectLoading());
      await firestoreService.editDoc(
          id: id, model: model, collectionReference: projectCollection);
      emit(UpdateProjectSuccess());
    } on FirebaseException catch (error) {
      print(error);
      print(error.code);
      print(error.message);
      emit(UpdateProjectFailure());
    }
  }



  Future<void> buildDeleteDocumentFunction({required String uid}) async {
    try {
      emit(DeleteProjectLoading());
      await firestoreService.deleteDoc(
          id: uid, collectionReference: projectCollection);
      emit(DeleteProjectSuccess());
    } on FirebaseException catch (error) {
      print(error);
      print(error.code);
      print(error.message);
      emit(DeleteProjectFailure());
    }
  }



}










import 'package:asec_application/firebase_services/firestore_service.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../model/Certification_model.dart';
part 'certification_state.dart';

class CertificationCubit extends Cubit<CertificationState> {
  CertificationCubit(this.fireStoreService) : super(CertificationInitial());

  FireStoreService fireStoreService;

  CollectionReference certificate =
      FirebaseFirestore.instance.collection('certificate');

  CollectionReference acceptCertificate =
  FirebaseFirestore.instance.collection('AcceptCertificate');

  static CertificationCubit get(context) => BlocProvider.of(context);

  List<CertificationModel> certificateList = [];
  List<CertificationModel> accptedCertificate = [];

  //get
  Future getCertificate() async {
    try {
      emit(CertificationLoading());

      await fireStoreService
          .getCollection(collectionReference: certificate)
          .then((value) {
        certificateList = [];

        for (var doc in value.docs) {
          certificateList.add(CertificationModel.fromJson(
              doc as QueryDocumentSnapshot<Map<String, dynamic>>));
        }
      });

      emit(CertificationSuccess());
    } catch (e) {
      print(e);
      emit(CertificationError());
    }
  }

  //set
  Future setCertificate({
    required String id,
    required String name,
    required String grade,
    required String nameCourses,
    required String stateCourses,
    required int degree,
    required String serialNumber
  }) async {
    CertificationModel certificationModel = CertificationModel(
        id: id,
        name: name,
        grade: grade,
        nameCourses: nameCourses,
        stateCourses: stateCourses,
        degree: degree,
      serialNumber: serialNumber
    );

    try {
      emit(CertificationLoading());

      await fireStoreService
          .setDoc(
              collectionReference: certificate,
              model: certificationModel.toJson(),
              uId: id)
          .then((value) {
        print("Your certification is Done");
      });

      emit(CertificationSuccess());
    } catch (e) {
      print(e);
      emit(CertificationError());
    }
  }





  Future acceptCertificateFunction({
    required String name,
    required String grade,
    required String nameCourses,
    required String stateCourses,
    required int degree,
    required String serialNumber
  }) async {
    CertificationModel certificationModel = CertificationModel(
        id: "1",
        name: name,
        grade: grade,
        nameCourses: nameCourses,
        stateCourses: stateCourses,
        degree: degree,
        serialNumber: serialNumber
    );

    try {
      emit(AcceptCertificationLoading());

      await fireStoreService
          .addDoc(
          collectionReference: acceptCertificate,
          model: certificationModel.toJson(),
          )
          .then((value) {
        print("certification is Accepted");
      });

      emit(AcceptCertificationSuccess());
    } catch (e) {
      print(e);
      emit(AcceptCertificationError());
    }
  }


  Future getCertificateAccpted() async {
    try {
      emit(CertificationLoading());

      await fireStoreService
          .getCollection(collectionReference: acceptCertificate)
          .then((value) {
        accptedCertificate = [];

        for (var doc in value.docs) {
          accptedCertificate.add(CertificationModel.fromJson(
              doc as QueryDocumentSnapshot<Map<String, dynamic>>));
        }
      });

      emit(CertificationSuccess());
    } catch (e) {
      print(e);
      emit(CertificationError());
    }
  }



}

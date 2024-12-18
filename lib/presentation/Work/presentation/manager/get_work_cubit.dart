import 'package:asec_application/Constant/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../firebase_services/firestore_service.dart';
import '../../data/ineer_response_model.dart';
import '../../data/inner_request_model.dart';
import '../../data/job_model.dart';

part 'get_work_state.dart';

class GetWorkCubit extends Cubit<GetWorkState> {
  GetWorkCubit(this.fireStoreService) : super(GetWorkInitial());

  static GetWorkCubit get(context) => BlocProvider.of(context);

  final FireStoreService fireStoreService;

  List<JobModel> jobList = [];
  List<InnerRequestModel> innerRequestList = [];
  List<InnerResponseModel> innerResponseList = [];

  final CollectionReference workCollection =
      FirebaseFirestore.instance.collection('Work');

  /////////////////////////////////////////////

  Future<void> getAllJobs() async {
    emit(GetJobsLoading());
    await fireStoreService
        .getCollection(collectionReference: workCollection)
        .then((value) {
      jobList = [];
      for (var doc in value.docs) {
        jobList.add(JobModel.fromJson(
            doc as QueryDocumentSnapshot<Map<String, dynamic>>));
      }

      emit(GetJobsSuccess());
    }).catchError((error) {
      emit(GetJobsError());
      print(error.toString());
    });
  }

/////////////////////////////////////////////

  Future<dynamic> getRequestCollection(BuildContext context) async {
    try {
      emit(GetRequestJobsLoading());
      FirebaseFirestore.instance
          .collection("Work")
          //constantvar.idRequestWorkCollection
          .doc(constantvar.idWork)
          .collection("Request")
          .get()
          .then((value) {
        innerRequestList = [];

        for (var doc in value.docs) {
          innerRequestList.add(InnerRequestModel.fromJson(doc));
        }

        emit(GetRequestJobsSuccess());
      });
    } catch (error) {
      print(error);

      emit(GetRequestJobsError());
    }
  }

  /////////////////////////////////////////////

  Future<dynamic> getResponseCollection(BuildContext context,
      {required String id}) async {
    try {
      emit(GetResponseCvLoading());
      FirebaseFirestore.instance
          .collection("Work")
          //constantvar.idResponseWorkCollection
          .doc(id)
          .collection("Response")
          .get()
          .then((value) {
        innerResponseList = [];

        for (var doc in value.docs) {
          innerResponseList.add(InnerResponseModel.fromJson(doc));

          emit(GetResponseCvSuccessLength());

          var x = innerResponseList.length;
          constantvar.innerResponseCounter = innerResponseList.length;
          print("xxxxxxxxxxxxxxxx====>>>>>>>>>>>>>>>>> $x");
        }

        emit(GetResponseCvSuccess());
      }).then((value) {
        // navigateTo(
        //     context, GetAllCvUser(
        //   innerResponseModel: innerResponseList,
        //   id: id,
        // ));
      });
    } catch (error) {
      print(error);

      emit(GetResponseCvError());
    }
  }

/////////////////////////////////////////////
/////////////////////////////////////////////

  Future<void> addExternalJob({
    required String code,
    required String company,
    required String date,
    required String email,
    required String location,
    required String name,
    required String nameJob,
    required String phone,
    required String possition,
    required String specialization,
    required String active,
    required String desc,
    required String skills,
    required String time,
    required String jopType,
    required String salary,
    required String image,
    required String experience,
  }) async {
    try {
      //var x = FirebaseFirestore.instance.collection("Work").add;
      var lastID = '';
      emit(SetJobLoading());
      FirebaseFirestore.instance.collection("Work").add({
        "code": code,
        "company": company,
        "date": date,
        "email": email,
        "location": location,
        "name": name,
        "nameJob": nameJob,
        "phone": phone,
        "possition": possition,
        "specialization": specialization,
        // "active":active,
        // "desc":desc,
        // "skills":skills,
        // "time":time,
        // "jopType":jopType,
        // "salary":salary,
        "image": image,
      }).then((docRef) {
        print("upload job done >>>>>>>>>>>>>>>>");
        lastID = docRef.id;

        FirebaseFirestore.instance
            .collection("Work")
            .doc(lastID)
            .collection("Request")
            .add({
          // "code":code,
          //"company":company,
          //"date":date,
          "email": email,
          "location": location,
          //"name":name,
          "nameJob": nameJob,
          "phone": phone,
          "possition": possition,
          "specialization": specialization,
          "active": active,
          "desc": desc,
          "skills": skills,
          "time": time,
          "jopType": jopType,
          "salary": salary,
          "image": image,
          "experience": experience
        }).then((value) {
          print("upload inner job done >>>>>>>>>>>>>>>>");
        });
      });
      emit(SetJobSuccess());
    } catch (error) {
      emit(SetJobError());
      print(error.toString());
    }
  }

  Future<void> setCvForJob({
    required String firstname,
    required String lastname,
    required String email,
    required String phone,
    required String linkedin,
    required String gpa,
    // required String degreeFinalProject,
    required String graduationYear,
    required String positionCv,
    required String addressStNum,
    required String addressStName,
    required String address,
    required String facebook,
    required String totalLikeCv,
    required String faculty,
    required String startDate,
    required String shareProject,
    required String specialization,
    required String companyName,
    required String state,
    required String military,
    required List pro,
    required bool work,
    required bool isTrain,
    required List listHobbies,
  }) async {
    InnerResponseModel innerResponseModel = InnerResponseModel(
        firstname: firstname,
        lastname: lastname,
        email: email,
        address: address,
        faculty: faculty,
        phone: phone,
        linkedin: linkedin,
        gpa: gpa,
        graduationYear: graduationYear,
        pro: pro,
        military: military,
        state: state,
        facebook: facebook,
        like: totalLikeCv,
        specialization: specialization,
        companyName: companyName,
        addressStName: addressStName,
        addressStNum: addressStNum,
        positionCv: positionCv,
        shareProject: shareProject,
        startDate: startDate,
        work: work,
        isTrain: isTrain,
        listHobbies: listHobbies);
    try {
      emit(SetGetResponseCvLoading());
      // await fireStoreService
      //     .setDoc(
      //     uId: FirebaseAuth.instance.currentUser!.uid,
      //     model: innerResponseModel.toJson(),
      //     collectionReference: cvCollection)

      //FirebaseFirestore.instance.collection("Work").doc(constantvar.idRequestWorkCollection).collection("Response").doc(FirebaseAuth.instance.currentUser!.uid).set(innerResponseModel.toJson())
      FirebaseFirestore.instance
          .collection("Work")
          .doc(constantvar.idWork)
          .collection("Response")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(innerResponseModel.toJson())
          .then((value) {
        print("CV Done Upload");
      });
      emit(SetResponseCvSuccess());
    } catch (error) {
      print(error.toString());
      emit(SetResponseCvError());
    }
  }
}

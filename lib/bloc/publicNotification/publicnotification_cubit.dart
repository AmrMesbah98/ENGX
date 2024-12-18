import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../api_service/api_service.dart';
import '../../firebase_services/firestore_service.dart';
import '../../model/notification_Show_model.dart';


part 'publicnotification_state.dart';

class PublicNotificationCubit extends Cubit<PublicNotificationState> {
  PublicNotificationCubit(this.apiService, this.fireStoreService) : super(PublicNotificationInitial());



  static PublicNotificationCubit get(context) => BlocProvider.of(context);


  final FireStoreService fireStoreService;

  final CollectionReference fcmCollection =
  FirebaseFirestore.instance.collection('FCM');

  List<NotificationShowModel> fcmModelList = [];


  ApiService apiService;

  sendPublicNotification( String title, String body, )
  async {
    try
    {
      emit(PublicNotificationLoading());
      await apiService.postData(data: {
        'to': '/topics/all',
        'notification': {
          "title": title,
          "body": body,
          "sound": "default"
        },

        // 'data': 'test',
      }).then((value) async {

      });
      // print( "the second is =>>>>>> $uid" );
      // constantvar.Uid = uid;
      emit(PublicNotificationSuccess());

    }
    catch(error)
    {
      print(error);
      emit(PublicNotificationError());
    }



  }



  Future<void> getFcm() async {
    emit(ShowNotificationLoading());
    await fireStoreService
        .getCollection(collectionReference: fcmCollection)
        .then((value) {
      fcmModelList = [];
      for (var doc in value.docs) {
        fcmModelList.add(NotificationShowModel.fromJson(
            doc as QueryDocumentSnapshot<Map<String, dynamic>>));
      }

      emit(ShowNotificationSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(ShowNotificationError());
    });
  }


  Future<void> seFcm({
    required String fcm,
    required String date

  }) async {
    NotificationShowModel fcmModelList = NotificationShowModel( text: fcm, date: date);
    try {
      emit(SetNotificationLoading());
      await fireStoreService
          .addDoc(
          model: fcmModelList.toJson(),
          collectionReference: fcmCollection)
          .then((value) {
        print("Notification Done Upload");
      });
      emit(SetNotificationSuccess());
    } catch (error) {
      print(error.toString());
      emit(SetNotificationError());
    }
  }






}

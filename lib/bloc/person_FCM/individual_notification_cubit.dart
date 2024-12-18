import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../api_service/api_service.dart';

part 'individual_notification_state.dart';

class IndividualNotificationCubit extends Cubit<IndividualNotificationState> {
  IndividualNotificationCubit(this.apiService)
      : super(IndividualNotificationInitial());

  static IndividualNotificationCubit get(context) => BlocProvider.of(context);
  ApiService apiService;

  sendIndividualNotification(String title, String body, String uid) async {
    try {
      emit(IndividualNotificationLoading());
      await apiService.postData(data: {
        'to': '/topics/$uid',
        'notification': {"title": title, "body": body, "sound": "default"},

        // 'data': 'test',
      }).then((value) async {});
      // print( "the second is =>>>>>> $uid" );
      // constantvar.Uid = uid;
      emit(IndividualNotificationSuccess());
    } catch (error) {
      print(error);
      emit(IndividualNotificationError());
    }
  }
}

import 'package:asec_application/Constant/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared_prefrance/shard_prefrance.dart';
import '../get_information/user_information_cubit.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  Future Login(BuildContext context, String email, String password) async {
    try {
      emit(AuthLoadingState());
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      await FirebaseMessaging.instance.subscribeToTopic('all');
      await FirebaseMessaging.instance
          .subscribeToTopic(userCredential.user!.uid);

      if (userCredential != null) {
        await CacheHelper.saveData(key: 'uId', value: userCredential.user!.uid);

        await UserAppInformationCubit.get(context).getInformation();

        constantvar.uid = CacheHelper.getData(key: "uId");

        emit(AuthSuccessUserState());
      }
    } on FirebaseAuthException catch (error) {
      print(error.code);
      print(error.message);

      var snackBar = SnackBar(
        content: Text(
          error.message!,
          style: TextStyle(fontSize: 15.sp),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      emit(AuthErrorState(error.toString()));
    }
  }
}
